defmodule Legion.Agents.ShoppingList do
  use Agent

  def start_link(_opts) do
    Agent.start_link(fn -> %{} end)
  end

  def start(_opts) do
    Agent.start(fn -> %{} end)
  end

  def get(agent, key) do
    Agent.get(agent, fn map -> Map.get(map, key) end)
  end

  def add(agent, key, value) do
    Agent.update(agent, fn map -> Map.put(map, key, value) end)
  end

  def delete(agent, key) do
    Agent.get_and_update(agent, fn map ->
      Map.pop(map, key)
    end)
  end

  def delete_wait(agent, key) do
    # puts client to sleep
    IO.puts("puts client to sleep")
    Process.sleep(2000)

    Agent.get_and_update(agent, fn map ->
      # puts server to sleep
      IO.puts("puts server to sleep")
      Process.sleep(2000)
      Map.pop(map, key)
    end)
  end
end
