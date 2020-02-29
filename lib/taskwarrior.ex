defmodule Taskwarrior do
  @moduledoc """
  Parses Taskwarrior data
  """

  @doc """
  Parses JSON data and returns Taskwarrior tasks
  """
  def from_json(json_data) do
    Jason.decode(json_data)
  end
end
