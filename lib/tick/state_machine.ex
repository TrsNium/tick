
defmodule Tick.StateMachine do
  defmacro __using__(_opts) do
    caller = __CALLER__.module
    quote location: :keep do

      def child_spec(args) do
        app = Application.get_application(unquote(caller))
        name = Keyword.get(args, :name, unquote(caller))
        data_dir =
          case Keyword.get(args, :data_dir) do
            nil ->
              # Default to a unique data dir for each node and state machine
              node_str = "#{Node.self}"
              root_dir = Application.app_dir(app, "data")
              Path.join([root_dir, node_str, "#{name}"])
            dir ->
              dir
          end
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
