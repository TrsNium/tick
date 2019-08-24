

defmodule Tick.Supervisor do
  use Supervisor

  def start_link(init_state) do
    Supervisor.start_link(__MODULE__, init_state, name: __MODULE__)
  end

  def init(init_state) do
    children = [
      {Tick.Server, init_state}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
