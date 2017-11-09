defmodule Console.Command do
  @moduledoc """
  command
  """
  defmacro __using__(_) do
    quote do
      use Mix.Task
      import unquote(__MODULE__)

      Module.register_attribute(__MODULE__, :switches, accumulate: true)
      @before_compile unquote(__MODULE__)

      def run(args) do
        args
        |> OptionParser.parse(parse_opts())
        |> IO.inspect()
      end
    end
  end

  defmacro __before_compile__(_env) do
    quote do
      def parse_opts do
        @switches
      end
    end
  end

  defmacro command(do: block) do
    quote do
      unquote(block)
    end
  end

  defmacro switch(name, type, opts \\ [])
           when is_atom(name) and type in ~w(boolean count integer float string)a do
    quote do
      @switches {unquote(name), unquote(type), unquote(opts)}
    end
  end
end
