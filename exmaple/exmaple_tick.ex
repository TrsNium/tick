
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
Supervisor.start_link([spec], :strategy: :one_for_one)

# execute block inside `tick`, and send message other nodes.
Tick.Example.increment(0)
