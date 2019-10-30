defmodule LegionTest do
  use ExUnit.Case
  doctest Legion

  test "greets the world" do
    assert Legion.hello() == :world
  end
end
