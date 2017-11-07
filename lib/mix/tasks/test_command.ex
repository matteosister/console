defmodule Mix.Tasks.Console do
  use Console.Command

  @shortdoc "test command"

  command do
    arg :file, :string
  end
end
