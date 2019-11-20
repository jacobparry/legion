defmodule Legion.Agents do
  @moduledoc """
  Agents are simple wrappers around state. If all you want from a process is to keep state, agents are a great fit.
  """

  def start() do
    Agent.start(fn -> [] end)
  end

  def start_link() do
    Agent.start_link(fn -> [] end)
  end

  @doc """
  The Agent.update/3 function accepts as second argument any function that receives one argument and returns a value:
  """
  def update(agent, item) do
    Agent.update(agent, fn list -> [item | list] end)
  end

  def get(agent) do
    Agent.get(agent, fn list -> list end)
  end

  def stop(agent) do
    Agent.stop(agent)
  end
end
