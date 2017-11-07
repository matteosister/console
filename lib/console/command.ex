defmodule Console.Command do
  @moduledoc """
  command
  """

  defmacro __using__(_) do
    quote do
      use Mix.Task
      import unquote(__MODULE__)

      Module.register_attribute(__MODULE__, :args, accumulate: true)
      @before_compile unquote(__MODULE__)

      def run(args) do
        IO.puts(inspect(args))
      end
    end
  end

  defmacro __before_compile__(_env) do
    quote do
      IO.inspect(@args)
    end
  end

  defmacro command(do: block) do
    quote do
      unquote(block)
    end
  end

  defmacro arg(name, type) do
    quote do
      @args %{name: unquote(name), type: unquote(type)}
    end
  end
end
