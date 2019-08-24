

defmodule Tick.Server.State do
  defstruct [
    current_state: %{},
    name: nil
  ]

  def new(current_state, name) do
    %__MODULE__{}
    |> Map.put(:current_state, current_state)
    |> Map.put(:name, name)
  end
end
