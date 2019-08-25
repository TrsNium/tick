

defmodule Tick.Server do
  use GenServer
  require Logger

  def send_state(state) do
    GenServer.call(__MODULE__, :current_state).config
      |> dest_address
      |> Enum.each(fn(address) -> spawn_task(__MODULE__, :received_state, address, [state, Node.self()]) end)
  end

  def receive_state(%Tick.Server.State{}=received_state, from) do
    state = GenServer.call(__MODULE__, :current_state)

    Logger.info("Get state from node(#{inspect from}): #{inspect received_state.current_state}")
    Logger.info("Number of steps that other nodes are proceeding with: #{number_of_steps_forward state.current_state, received_state.current_state}")

    other_names = Map.keys(state.current_state)
                    |> List.delete(state.name)

    state_incremented = %{ state.current_state | state.name => state.current_state[state.name] + 1 }
    state_apply_received_state = Enum.reduce(other_names, state_incremented, fn(name, state) -> %{state | name => received_state[name]} end)
    Logger.info("Updated current state: #{inspect state_apply_received_state}")

    GenServer.cast(__MODULE__, {:update_state, Tick.Server.State.new(state_apply_received_state, state.name)})
  end

  defp number_of_steps_forward(self_state, received_state) do
    Enum.zip([Map.keys(self_state), Map.values(self_state), Map.values(received_state)])
      |> Enum.map(fn({key, self, received})-> "#{key} => #{received - self}" end)
      |> Enum.join(", ")
  end

  def finish_process() do
    state = GenServer.call(__MODULE__, :current_state)
    updated_current_state = %{state.current_state | state.name => state.current_state[state.name] + 1}
    Logger.info("Updated current state: #{inspect updated_current_state}")
    new_state = Tick.Server.State.new(updated_current_state, state.name)
    GenServer.cast(:update_state, new_state)
  end

  # Return current status
  def handle_call(:current_state, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:update_state, %Tick.Server.State{}=new_state}, _) do
    {:noreply, new_state}
  end

  def handle_cast({:finish_process, _}, state) do
    current_state = state.
  end

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(state) do
    {:ok, state}
  end
end
