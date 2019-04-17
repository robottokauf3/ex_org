defmodule ExOrg.Helpers.Table do
  @moduledoc """
  Responsible for parsing Table structure.

  Reference: https://orgmode.org/worg/dev/org-syntax.html#Table_Rows
  """

  alias ExOrg.LineTypes.TableRow

  @doc """

  """
  def parse(content) do
    %TableRow{cells: split_table_cells(content)}
  end

  defp split_table_cells(row) do
    row
    |> String.trim("|")
    |> String.split("|")
    |> Enum.map(&String.trim/1)
  end
end
