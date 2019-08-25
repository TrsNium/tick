

defmodule Tick.Server.State do
  defstruct [
    current_state: %{},
    name: nil,
    config: %Tick.Config{}
  ]

  def new(current_state, name) do
    %__MODULE__{}
    |> Map.put(:current_state, current_state)
    |> Map.put(:name, name)
  end
end
