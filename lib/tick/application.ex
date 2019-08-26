
defmodule Tick.Application do
  use Application

  def start(_type, _args) do
    children = [
      {Task.Supervisor, name: Tick.TaskSupervisor}
    ]

    opts = [strategy: :one_for_one, name: Tick.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
