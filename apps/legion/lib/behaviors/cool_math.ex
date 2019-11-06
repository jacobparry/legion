defmodule Legion.Behaviors.CoolMath do
  @callback square(Integer.t()) :: Integer.t()
  @callback add(Integer.t(), Integer.t()) :: Integer.t()
end
