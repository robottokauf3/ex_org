defmodule ExOrg do
  @moduledoc """
  Parses list of Org mode lines into tokenized tree.
  """
  defdelegate parse(lines), to: ExOrg.Parser
  defdelegate parse(lines, options), to: ExOrg.Parser
end
