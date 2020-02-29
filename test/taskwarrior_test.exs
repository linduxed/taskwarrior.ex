defmodule TaskwarriorTest do
  use ExUnit.Case

  describe "from_json/1" do
    test "returns an empty list if JSON is empty list" do
      json_data = "[]\n"

      assert {:ok, tasks} = Taskwarrior.from_json(json_data)
      assert tasks == []
    end
  end
end
