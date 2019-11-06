defmodule Legion.Servers.SelfContained do
  use GenServer

  # Client
  def start_link(args \\ [], opts \\ []) do
    GenServer.start_link(__MODULE__, args, opts)
  end

  def marco_sync(server) do
    GenServer.call(server, :marco)
  end

  def marco_async(server) do
    GenServer.cast(server, :marco)
  end

  # Server
  def init(args) do
    state = args
    {:ok, state}
  end

  def handle_call(:marco, _from, state) do
    Process.sleep(3000)
    {:reply, :polo, state}
  end

  def handle_cast(:marco, state) do
    Process.sleep(3000)
    IO.puts("polo")
    {:noreply, state}
  end
end
