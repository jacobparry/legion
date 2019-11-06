defmodule Legion.Servers.Basic do
  @behaviour GenServer

  def init(args) do
    state = args
    {:ok, state}
  end

  @doc """
  There are two types of requests you can send to a GenServer: calls and casts.
  Calls are synchronous and the server must send a response back to such requests.
  While the server computes the response, the client is waiting.
  Casts are asynchronous: the server won’t send a response back and therefore the client won’t wait for one.
  Both requests are messages sent to the server, and will be handled in sequence.
  """
  def handle_call(:marco, _from, state) do
    Process.sleep(2000)
    {:reply, :polo, state}
  end

  def handle_cast(:marco, state) do
    Process.sleep(3000)
    IO.puts("polo")
    {:noreply, state}
  end
end
