defmodule Taskwarrior do
  @moduledoc """
  Parses Taskwarrior data
  """

  alias Taskwarrior.Task

  @doc """
  Parses Taskwarrior JSON data and returns a list of Taskwarrior.Task items

  This function makes assumption that the JSON that is provided originates from
  Taskwarrior's data exporting command: `task export`. This allows us to make
  certain assumptions, such as the JSON being valid, and that dates (and other
  details) are formatted in a specific way.
  """
  def from_json(json_data) do
    json_data
    |> Jason.decode!()
    |> Enum.map(&Task.build/1)
  end
end
