
defmodule Tick.Config do
  defstruct [
    self_name: nil,
    dest_info: []
  ]

  def new(name, dest_info) do
    %__MODULE__{}
      |> Map.put(:self_name, name)
      |> Map.put(:dest_info, Enum.map(dest_info,
          fn({name, address})-> Tick.DestInfo.new(name, address) end))
  end

  def dest_address(%Tick.Config{}=config) do
    config.dest_info
      |> Enum.filter(fn(dest_info)-> dest_info.address != nil end)
      |> Enum.map(fn(dest_info)-> dest_info.address end)
  end
end

defmodule Tick.DestInfo do
  defstruct [
    name: nil,
    address: nil
  ]

  def new(name, address) do
    %__MODULE__{}
      |> Map.put(:name, name)
      |> Map.put(:address, address)
  end
end
