defmodule Operations do

  def swap({a, b}) do
    {b, a}
  end

  def same(a, a) do
    true
  end

  def same(_, _) do
    false
  end

end
