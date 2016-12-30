defmodule ExOrg.Parser do

  @moduledoc """
  Given list of Org mode lines returns tokenized tree.
  """

  alias ExOrg.Line

  def parse([], _), do: []

  def parse([line | rest], options) do
    [Line.parse(line) | parse(rest, options)]
  end

end
