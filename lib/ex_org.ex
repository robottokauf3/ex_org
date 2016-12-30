defmodule ExOrg do

  @moduledoc """
  Parses list of Org mode lines into tokenized tree.
  """

  def parse(content), do: parse(content, %ExOrg.Options{})

  def parse(content, options) do
    ExOrg.Parser.parse(content, options)
  end

end
