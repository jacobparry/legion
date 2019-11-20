defmodule Legion.Behaviors.Subtraction do
  @behaviour Legion.Behaviors.CoolMath

  def add(int, int2) do
    int + int2
  end

  def square(int) do
    int * int
  end
end
