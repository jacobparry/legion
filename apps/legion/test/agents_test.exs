defmodule Legion.AgentsTest do
  use ExUnit.Case, async: true

  test "stores values by key" do
    {:ok, agent} = Legion.Agents.ShoppingList.start_link([])
    assert Legion.Agents.ShoppingList.get(agent, :milk) == nil

    Legion.Agents.ShoppingList.add(agent, :milk, 3)
    assert Legion.Agents.ShoppingList.get(agent, :milk) == 3
  end
end
