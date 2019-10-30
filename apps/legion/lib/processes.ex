defmodule Legion.Processes do
  def spawn_process() do
    spawn(fn ->
      IO.puts(1 + 2)
    end)
  end

  def spawn_bad_process() do
    spawn(fn ->
      raise "my bad"
    end)
  end

  def spawn_linked_process() do
    # spawn_link creates a process linked to the current process, self() in this case.
    spawn_link(fn ->
      IO.puts(1 + 2)
    end)
  end

  def spawn_linked_bad_process() do
    # spawn_link creates a process linked to the current process, self() in this case.
    spawn_link(fn ->
      raise "oopsie"
    end)
  end

  def is_spawned_process_alive?(pid) do
    Process.alive?(pid)
  end

  def who_am_i() do
    self()
  end

  def send_message_to_self() do
    send(self(), {:hello, "world"})
  end

  def send_message_to_process(pid) do
    send(pid, {:hello, "world"})
  end

  def receive_message_from_current_process() do
    receive do
      {:hello, msg} -> msg
      {:world, _msg} -> "won't match"
    end
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

  def get_information_about_process_mailbox(pid) do
    Process.info(pid, :message_queue_len)
  end

  def sending_lots_of_message_to_self() do
    Enum.each(1..100, fn int ->
      send(self(), int)
    end)
  end

  def spawn_lots_of_processes_to_send_message() do
    daddy = self()

    Enum.each(1..100, fn int ->
      spawn(fn -> send(daddy, int) end)
    end)
  end

  def give_process_a_name(pid, name) do
    Process.register(pid, name)
  end

  def find_named_processes() do
    Process.registered()
  end
end
