defmodule Console.Help do
  @moduledoc """
  help module
  """

  import Enum
  alias Console.Switch

  def output(config, shortdoc) do
    IO.puts(shortdoc)
    IO.puts("")

    pad =
      config
      |> map(& &1.name)
      |> map(&to_string/1)
      |> map(&String.length/1)
      |> max

    Enum.each(config, &output_switch(&1, pad))
  end

  defp output_switch(%Switch{name: name, desc: desc, type: :boolean}, pad) do
    IO.puts("  --#{String.pad_trailing(to_string(name), pad + 3)} - #{desc}")
    IO.puts("  --no-#{String.pad_trailing(to_string(name), pad)} - #{desc}")
  end

  defp output_switch(%Switch{name: name, desc: desc, type: :string}, pad) do
    IO.puts("  --#{String.pad_trailing(to_string(name), pad + 3)} - #{desc}")
  end
end
