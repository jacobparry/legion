defmodule Legion.Tasks do
  @moduledoc """
  Tasks build on top of the spawn functions to provide better error reports and introspection:

  iex(1)> Task.start fn -> raise "oops" end
  {:ok, #PID<0.55.0>}

  15:22:33.046 [error] Task #PID<0.55.0> started from #PID<0.53.0> terminating
  ** (RuntimeError) oops
    (stdlib) erl_eval.erl:668: :erl_eval.do_apply/6
    (elixir) lib/task/supervised.ex:85: Task.Supervised.do_apply/2
    (stdlib) proc_lib.erl:247: :proc_lib.init_p_do_apply/3
  Function: #Function<20.99386804/0 in :erl_eval.expr/5>
    Args: []
  """

  def start() do
    Task.start(fn -> "Heyo" end)
  end

  def start_link() do
    Task.start_link(fn -> "Heyo" end)
  end

  def start_bad() do
    Task.start(fn -> raise "oopsie" end)
  end

  def start_link_bad() do
    Task.start_link(fn -> raise "oopsie" end)
  end

  def task_store_state do
    Task.start_link(fn -> loop(%{}) end)
  end

  defp loop(map) do
    receive do
      {:get, key, caller} ->
        send(caller, Map.get(map, key))
        loop(map)

      {:put, key, value} ->
        new_map = Map.put(map, key, value)
        loop(new_map)
    end
  end

  def give_process_a_name(pid, name) do
    Process.register(pid, name)
  end

  def find_named_processes() do
    Process.registered()
  end
end
