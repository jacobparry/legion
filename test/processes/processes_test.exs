defmodule Legion.ProcessesTest do
  use ExUnit.Case
  doctest Legion

  alias Legion.Processes

  test "Spawn process" do
    pid = Processes.spawn_process()

    assert is_pid(pid)
  end
end
