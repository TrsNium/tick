
defmodule Tick.StateMachine do
  defmacro __using__(_opts) do
    caller = __CALLER__.module
    quote location: :keep do
      def child_spec(%Tick.Config{}=config) do
        init_opts = %Tick.Server.State{}
          |> Map.put(:current_state, Tick.Server.State.init_current_state(config))
          |> Map.put(:config, config)

        Supervisor.child_spec({Tick.PeerSupervisor, init_opts}, name: Tick.PeerSupervisor)
      end

      defmacrop tick(do: block) do
        quote do
          #TODO:
          # Wait if no message arrives.
          unquote(block)
          # Send a message to each node
        end
      end

    end
  end
end
