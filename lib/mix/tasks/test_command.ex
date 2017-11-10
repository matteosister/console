defmodule Mix.Tasks.Console.Test do
  use Console.Command

  @shortdoc "test command"

  command do
    switch :file, :string, alias: :f, desc: "file path"
    switch :flag, :boolean
  end
end
