defmodule Legion.Servers.Registry do
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
  def handle_call({:lookup, name}, _from, names) do
    {:reply, Map.fetch(names, name), names}
  end

  def handle_cast({:create, name}, names) do
    if Map.has_key?(names, name) do
      {:noreply, names}
    else
      {:ok, shopping_list} = Legion.Agents.ShoppingList.start_link([])
      {:noreply, Map.put(names, name, shopping_list)}
    end
  end
end
