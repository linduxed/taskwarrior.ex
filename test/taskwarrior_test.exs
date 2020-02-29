defmodule TaskwarriorTest do
  use ExUnit.Case
  doctest Taskwarrior

  test "greets the world" do
    assert Taskwarrior.hello() == :world
  end
end
