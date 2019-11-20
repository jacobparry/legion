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

  def max_out_our_atoms() do
    # In erlang the number of atoms you can create is limited to 1,048,576, and it's not garbage collected
    # :erlang.system_info(:atom_limit)
    # :erlang.system_info(:atom_count)

    Enum.each(1..1_100_000, fn int ->
      "haha_sucka_erlang_vm_limit_#{int}"
      |> String.to_atom()
    end)
  end

  def max_out_our_processes() do
    # In erlang the number of processes you can create is limited to 262144
    # :erlang.system_info(:process_limit)
    # :erlang.system_info(:process_count)

    Enum.each(1..300_000, fn _ ->
      {:ok, _pid} = ShoppingList.start([])
    end)
  end
end
