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

  ## User Defined Attributes (UDA)

  To read in UDAs, provide an `opts` keyword list as the second parameter, with
  the `opts[:udas]` key populated with an "UDA list".

  For UDAs of `numeric`, `string`, and `duration` types, just provide the name
  of the UDA in the form of an atom, matching the name of the UDA (e.g.
  `:foobar`). Note that `duration` UDAs will not be parsed: the `duration`
  string will simply be read and stored.

  For UDAs with the `date` type, provide these as keyword list tuples with the
  second element being `:date` (e.g. `{:foobar, :date}`). This is necessary to
  indicate that the date should be parsed into a native date struct (otherwise
  it will simply be read as a string).

  ## Examples

      iex> Taskwarrior.from_json(json_data)
      [%Taskwarrior.Task{...}, ...]

      iex> Taskwarrior.from_json(json_data, udas: [:foobar, :baz])
      [%Taskwarrior.Task{...}, ...]

      iex> Taskwarrior.from_json(json_data, udas: [:foobar, :baz, quux: :date])
      [%Taskwarrior.Task{...}, ...]
  """
  def from_json(json_data, opts \\ []) do
    json_data
    |> Jason.decode!()
    |> Enum.map(&Task.build(&1, opts))
  end
end
