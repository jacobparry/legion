1. Empty GenServer

  1. `{:ok, server} = GenServer.start_link(Legion.Servers.Empty, [])`
  2. `:observer.start()`
  3. `GenServer.call(server, :marco)`

2. Basic GenServer

  1. `{:ok, server} = GenServer.start_link(Legion.Servers.Basic, [])`
  2. `:observer.start()`
  3. Review Callbacks
  4. `GenServer.call(server, :marco)`
  5. `GenServer.cast(server, :marco)`

3. Self-Contained GenServer

  1. Introduce client functions
  2. `{:ok, server} = Legion.Servers.SelfContained.start_link()`
  3. `:observer.start()`
  4. `Legion.Servers.SelfContained.marco_sync(server)`
  5. `Legion.Servers.SelfContained.marco_async(server)`

4. Working with State

  1. Introduce new GenServer
  2. `{:ok, server} = Servers.Counter.start_link()`
  3. `Servers.Counter.increment(server)`
  4. `Servers.Counter.decrement(server)`
  5. `GenServer.stop(server)`
  6. `{:ok, server} = Servers.Counter.start_link([starting_value: 100])`
  7. `Servers.Counter.increment(server)`
  8. `Servers.Counter.decrement(server)`

5. Complex GenServer

  1. Introduce new GenServer
  2. `{:ok, server} = Servers.Complex.start_link()`
  3. `user1 = "alice"`
  4. `user2 = "bob"`
  5. `Servers.Complex.register(user1, server)`
  6. `Servers.Complex.greet(user1, server)`
  7. `Servers.Complex.greet(user2, server)`
  8. `Servers.Complex.register(user2, server)`
  9. `Servers.Complex.greet(user2, server)`
  10. `Servers.Complex.greet(user1, server)`

6. Be Aware

  1. Create a bottleneck where one didn't exist
  2. Watch the message backlog

    - Self-Contained: `Enum.each(1..10, fn _ -> Servers.Contained.marco_async(server) end)`

7. Registry

  1. Atom Limit

    - Legion.Servers.max_out_our_atoms()

  2. Process Limit

    - Legion.Servers.max_out_our_processes()

  3. Monitoring

    - {:ok, list} = Legion.Agents.ShoppingList.start_link([])
    - Process.monitor(list)
    - Legion.Servers.Registry.create(registry, "shopping")
