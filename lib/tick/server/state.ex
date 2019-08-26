

defmodule Tick.Server.State do
  defstruct [
    current_state: %{},
    config: %Tick.Config{}
  ]

  def new(current_state, config) do
    %__MODULE__{}
      |> Map.put(:current_state, current_state)
      |> Map.put(:config, config)
  end

  def init_current_state(%Tick.Config{}=config) do
    Enum.reduce(config.dest_info, %{}, fn(dest_info, acc)-> Map.put(acc, dest_info.name, 0) end)
  end
end
