defmodule Legion.Servers.Counter do
  use GenServer

  # Client
  def start_link(args \\ [], opts \\ []) do
    GenServer.start_link(__MODULE__, args, opts)
  end

  def increment(server) do
    GenServer.call(server, :increment)
  end

  def decrement(server) do
    GenServer.call(server, :decrement)
  end

  # Server
  def init(args) do
    state = Keyword.get(args, :starting_value, 0)
    {:ok, state}
  end

  def handle_call(:increment, _from, state) do
    new_state = state + 1
    {:reply, new_state, new_state}
  end

  def handle_call(:decrement, _from, state) do
    new_state = state - 1

    "* * * * *"

    {:reply, new_state, new_state}
  end
end
