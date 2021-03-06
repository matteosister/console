defmodule Console.Command do
  @moduledoc """
  command
  """
  alias Console.Switch

  defmacro __using__(_) do
    quote do
      use Mix.Task
      import unquote(__MODULE__)

      Module.register_attribute(__MODULE__, :switches, accumulate: true)
      @before_compile unquote(__MODULE__)

      def run(args) do
        shortdoc =
          case List.keyfind(__MODULE__.__info__(:attributes), :shortdoc, 0) do
            {:shortdoc, [shortdoc]} -> shortdoc
            _ -> nil
          end

        args
        |> OptionParser.parse(parse_opts())
        |> Console.Command.maybe_output_help(config(), shortdoc)
      end
    end
  end

  def maybe_output_help({parsed, _, errors}, config, shortdoc) do
    if Keyword.has_key?(parsed, :help) || Keyword.has_key?(errors, :help) do
      Console.Help.output(config, shortdoc)
      System.halt()
    end
  end

  def do_output_help(config) do
    IO.inspect(config)
  end

  defmacro __before_compile__(_env) do
    quote do
      def parse_opts do
        switches = Enum.map(@switches, &Switch.as_definition/1)
        [switches: switches]
      end

      def config do
        @switches
      end
    end
  end

  defmacro command(do: block) do
    quote do
      @switches Switch.new(:help, :boolean, desc: "print this help")
      unquote(block)
    end
  end

  defmacro switch(name, type, opts \\ []) when is_atom(name) do
    quote do
      @switches Switch.new(unquote(name), unquote(type), unquote(opts))
    end
  end
end
