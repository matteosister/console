defmodule Console.Switch do
  @moduledoc """
  console command switch
  """
  @type t :: %__MODULE__{}

  @types ~w(boolean count integer float string)a

  defstruct name: nil, type: nil, desc: nil

  @spec new(atom(), atom(), Keyword.t()) :: t()
  def new(name, type, opts) when type in @types do
    %__MODULE__{name: name, type: type, desc: Keyword.get(opts, :desc)}
  end

  def new(name, type, _) do
    raise "the type \"#{type}\" for console command \"#{name}\" is not valid. Valid types are \"#{
            Enum.join(@types, "\", \"")
          }\""
  end

  def as_definition(%__MODULE__{name: name, type: type}) do
    {name, type}
  end
end
