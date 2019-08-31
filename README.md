# Tick

`tick` is a library for vector clock.
If you have a request, please make an issue.

## usage

```elixir 
# define your processing.
defmodule Tick.Example do
  use Tick.StateMachine

  def increment(n) do
    tick do
      n + 1
    end
  end
end

# make a config to send other nodes.
config = Tick.Config.new(:my_name, [{:my_name, nil}, {:other_node_name, :other_node_name@address}])
# get a spec to generate supervisor
spec = Tick.Example.child_spec(config)
Supervisor.start_link([spec], strategy: :one_for_one)

# execute block inside `tick`, and send message other nodes.
Tick.Example.increment(0)
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `tick` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:tick, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/tick](https://hexdocs.pm/tick).

