defmodule Legion.ProcessesTest do
  use ExUnit.Case
  doctest Legion

  alias Legion.Processes
  alias Legion.CheatSheets.Processes, as: CSP

  test "Spawn process" do
    pid = Processes.spawn_process()
    assert is_pid(pid)
  end

  test "spawn process that crashes" do
    pid = Processes.spawn_bad_process()
    assert is_pid(pid)
  end

  test "spawn linked_process " do
    pid = Processes.spawn_linked_process()
    assert is_pid(pid)
  end

  test "spawn a linked_process that crashes" do
    # This one may take down the whole test
    pid = Processes.spawn_linked_bad_process()
    assert is_pid(pid)
  end

  test "find self" do
    pid = Processes.who_am_i()
    assert is_pid(pid)
  end

  test "send message to current process" do
    msg = Processes.send_message_to_self()
    assert msg == {:hello, "world"}
  end

  test "send message to current any process" do
    pid = Processes.spawn_process()
    msg = Processes.send_message_to_process(pid)
    assert msg == {:hello, "world"}
  end

  test "receive message from current process" do
    Processes.send_message_to_self()
    msg = Processes.receive_message_from_current_process()
    assert msg == "world"
  end
end
