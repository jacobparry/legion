defmodule Legion.Processes do
  def spawn_process() do
    # Spawn a process here
  end

  def spawn_bad_process() do
    # Spawn a process that raises an error here
  end

  def spawn_linked_process() do
    # spawn a linked process here.
  end

  def spawn_linked_bad_process() do
    # Spawn a linked process that raises an error here
  end

  def is_spawned_process_alive?(pid) do
    # check if process is alive
  end

  def who_am_i() do
    # return the current process pid
  end

  def send_message_to_self() do
    # send a message to current process pid
  end

  def send_message_to_process(pid) do
    # send a message to any pid
  end

  def receive_message_from_current_process() do
    # receive a sent message
  end

  def timout_waiting_to_receive_message() do
    receive do
      {:hello, msg} -> msg
    after
      1_000 -> "nothing after 1s"
    end
  end

  def send_message_between_processes() do
    parent =
      self()
      |> IO.inspect(label: :parent_pid)

    spawn(fn ->
      child =
        self()
        |> IO.inspect(label: :child_pid)

      send(parent, {:hello, child})
    end)

    receive do
      {:hello, pid} -> "#{inspect(self())} got hello from #{inspect(pid)}"
    end
  end

  def show_mailbox_priority do
    pid = spawn(&selective_receive/0)
    send(pid, :message1)
    send(pid, :message2)
    send(pid, :message3)

    :ok
  end

  def show_mailbox_receive_wait() do
    pid = spawn(&non_picky_receive/0)
    IO.inspect(is_spawned_process_alive?(pid))

    Process.sleep(1000)
    send(pid, "You waited for me!")
    Process.sleep(1000)
    IO.inspect(is_spawned_process_alive?(pid))

    :ok
  end

  def non_picky_receive() do
    receive do
      message -> IO.puts("Yay! Got a message: #{inspect(message)}")
    end
  end

  def selective_receive() do
    receive do
      :message3 -> IO.puts("Got message 3")
    end

    receive do
      :message2 -> IO.puts("Got message 2")
    end

    receive do
      :message1 -> IO.puts("Got message 1")
    end
  end

  def flushing_when_in_iex do
    # flush() - prints out all messages in the mailbox
  end
end
