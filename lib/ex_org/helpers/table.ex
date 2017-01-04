defmodule ExOrg.Helpers.Table do
  @moduledoc """
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
