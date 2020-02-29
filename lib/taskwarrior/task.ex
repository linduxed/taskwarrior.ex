defmodule Taskwarrior.Task do
  @moduledoc """
  A representation of a Taskwarrior task

  The struct field names are, to the degree that it's possible, following the
  names of the fields that are found in JSON exports from Taskwarrior's `task
  export`.

  Notes about the structs:

  * Some fields are not always set. Examples would be a task having no project,
    or `end` not being set due to the task not having the `status` of
    `completed`. In these cases, the value will be set to `nil`.
  * The `Taskwarrior.Task` structs do not have all of the fields that
    Taskwarrior tasks can possibly have. This is primarily due to functionality
    not being implemented yet.
  """

  defstruct [
    :id,
    :uuid,
    :description,
    :due,
    :end,
    :entry,
    :modified,
    :project,
    :status,
    :tags,
    :urgency
  ]

  @doc """
  Builds a Task struct from a JSON-decoded Taskwarrior task

  The `Task` struct created by this function mostly consist of unmodified data
  from the exported Taskwarrior task.

  **Note:** The dates are parsed as `DateTime` structs with the timezone being
  set to UTC, which is how Taskwarrior stores its time values. Currently there
  is no way to have the values be converted to an alternative timezone.
  """
  def build(task) do
    %__MODULE__{
      id: task["id"],
      uuid: task["uuid"],
      description: task["description"] || "",
      due: parse_iso_date(task["due"]),
      end: parse_iso_date(task["end"]),
      entry: parse_iso_date(task["entry"]),
      modified: parse_iso_date(task["modified"]),
      project: task["project"],
      status: task["status"],
      tags: task["tags"] || [],
      urgency: task["urgency"]
    }
  end

  defp parse_iso_date(nil), do: nil

  # This function assumes that the Taskwarrior always exports date and time in
  # the "basic format" of ISO 8601. See https://en.wikipedia.org/wiki/ISO_8601
  # for more details.
  #
  # The function also assumes that Taskwarrior neither sets nor exports invalid
  # dates, hence the optimistic code.
  defp parse_iso_date(
         <<
           year::binary-size(4),
           month::binary-size(2),
           day::binary-size(2)
         >> <>
           "T" <>
           <<
             hour::binary-size(2),
             minute::binary-size(2),
             second::binary-size(2)
           >> <>
           "Z"
       ) do
    {:ok, naive_date_time} =
      NaiveDateTime.new(
        String.to_integer(year),
        String.to_integer(month),
        String.to_integer(day),
        String.to_integer(hour),
        String.to_integer(minute),
        String.to_integer(second)
      )

    DateTime.from_naive!(naive_date_time, "Etc/UTC")
  end
end
