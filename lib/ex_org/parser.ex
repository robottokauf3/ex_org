defmodule ExOrg.Parser do

  @moduledoc """
  Given list of Org mode lines returns tokenized tree.
  """

  alias ExOrg.Line

  @doc """
  Parses a list of lines into block types.
  """
  def parse([], _), do: []

  def parse([line | rest], options) do
    [Line.parse(line) | parse(rest, options)]
  end

end
