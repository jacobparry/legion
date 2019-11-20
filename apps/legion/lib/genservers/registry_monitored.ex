defmodule Legion.Servers.RegistryMonitored do
  use GenServer

  ## Client API

  @doc """
  Starts the registry.
  """
  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  @doc """
  Looks up the list pid for `name` stored in `server`.

  Returns `{:ok, pid}` if the list exists, `:error` otherwise.
  """
  def lookup(server, name) do
    GenServer.call(server, {:lookup, name})
  end

  @doc """
  Ensures there is a list associated with the given `name` in `server`.
  """
  def create(server, name) do
    GenServer.cast(server, {:create, name})
  end

  ## Defining GenServer Callbacks

  def init(:ok) do
    {:ok, %{}}
  end

  # request, pid, state
  def handle_call({:lookup, name}, _from, state) do
    {names, _} = state
    {:reply, Map.fetch(names, name), state}
  end

  def handle_cast({:create, name}, {names, monitors}) do
    if Map.has_key?(names, name) do
      {:noreply, {names, monitors}}
    else
      {:ok, shopping_list} = Legion.Agents.ShoppingList.start_link([])
      reference_monitor = Process.monitor(shopping_list)
      monitors = Map.put(monitors, reference_monitor, name)
      names = Map.put(names, name, shopping_list)
      {:noreply, {names, monitors}}
    end
  end

  def handle_info({:DOWN, ref, :process, _pid, _reason}, {names, refs}) do
    {name, refs} = Map.pop(refs, ref)
    names = Map.delete(names, name)
    {:noreply, {names, refs}}
  end

  def handle_info(_msg, state) do
    {:noreply, state}
  end
end
