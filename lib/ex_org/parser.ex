defmodule ExOrg.Parser do
  @moduledoc """
  Given list of Org mode lines returns tokenized tree.
  """

  alias ExOrg.Line
  alias ExOrg.Options

  @doc """
  Parses a list of lines into block types.
  """
  def parse(lines, options \\ %Options{})

  def parse([], _), do: []

  def parse([line | rest], options) do
    [Line.parse(line) | parse(rest, options)]
  end
end
