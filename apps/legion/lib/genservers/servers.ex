defmodule Legion.Servers do
  alias Legion.Agents.ShoppingList

  def name_our_agents(num_agents) do
    Enum.each(1..num_agents, fn int ->
      name =
        "shopping_list_#{int}"
        |> String.to_atom()

      {:ok, pid} = ShoppingList.start_link([])
      Process.register(pid, name)
    end)
  end

  def stop_our_agents(num_agents) do
    Enum.each(1..num_agents, fn int ->
      name =
        "shopping_list_#{int}"
        |> String.to_atom()

      Agent.stop(name)
    end)
  end
end
