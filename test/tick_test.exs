defmodule TickTest do
  use ExUnit.Case
  doctest Tick

  test "greets the world" do
    assert Tick.hello() == :world
  end
end
