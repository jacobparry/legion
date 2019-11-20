defmodule Legion.Servers.RegistryTest do
  use ExUnit.Case, async: true

  setup do
    # The advantage of using start_supervised! is that ExUnit will guarantee that the registry process will be shutdown before the next test starts.
    # In other words, it helps guarantee that the state of one test is not going to interfere with the next one in case they depend on shared resources.
    # When starting processes during your tests, we should always prefer to use start_supervised!.

    registry = start_supervised!(Legion.Servers.Registry)
    %{registry: registry}
  end

  test "spawns lists", %{registry: registry} do
    assert Legion.Servers.Registry.lookup(registry, "shopping") == :error

    Legion.Servers.Registry.create(registry, "shopping")
    assert {:ok, list} = Legion.Servers.Registry.lookup(registry, "shopping")

    Legion.Agents.ShoppingList.add(list, "milk", 1)
    assert Legion.Agents.ShoppingList.get(list, "milk") == 1
  end

  test "we still hit the process limit", %{registry: registry} do
    for int <- 1..500_000 do
      Legion.Servers.Registry.create(registry, "shopping_#{int}")
    end
  end

  test "removes list on exit", %{registry: registry} do
    Legion.Servers.Registry.create(registry, "shopping")
    assert {:ok, list} = Legion.Servers.Registry.lookup(registry, "shopping")
    Agent.stop(list)
    assert Legion.Servers.Registry.lookup(registry, "shopping") == :error
  end
end
