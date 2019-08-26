
defmodule Tick.StateMachine do
  defmacro __using__(_opts) do
    caller = __CALLER__.module
    quote location: :keep do
      def child_spec(%Tick.Config{}=config) do
        #TODO: generate config for `server.ex`
      end

      defmacrop tick(do: block) do
        quote do
          # Wait if no message arrives.
          unquote(block)
          # Send a message to each node
        end
      end

    end
  end
end

defmodule Test do
  use Tick.StateMachine

  def test1 do
    tick do
      IO.puts "test1"
    end
  end
end
