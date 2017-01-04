defmodule ExOrg.Helpers.Clock do
  @moduledoc """
  Responsible for parsing clock directives.
  """

  alias ExOrg.LineTypes

  @doc """
  """
  def parse([_, timestamp, _, duration]) do
    %LineTypes.Clock{timestamp: parse_timestamp(timestamp),
                     duration: duration_in_minutes(duration)}
  end
  def parse([_, timestamp]) do
    %LineTypes.Clock{timestamp: parse_timestamp(timestamp)}
  end

  def parse(_) do
    %LineTypes.Clock{}
  end

  @doc """
  Takes a string in the format of HH:MM and returns the duration in minutes.
  """
  def duration_in_minutes(duration) do
    [hours, minutes] = duration
    |> String.split(":")
    |> Enum.map(&String.to_integer/1)

    hours * 60 + minutes
  end

  @doc """
  Takes timestamp and returns map containing start and end DateTime structs.

  The following input formats are valid:
  `[2017-01-01 Sun 23:49]`
  `[2017-01-01 Sun 23:48]--[2017-01-01 Sun 23:49]`
  """
  def parse_timestamp(timestamp) do
    case String.split(timestamp, "--") do
      [start] ->
        %{start: _parse_timestamp(start), end: nil}
      [start, stop] ->
        %{start: _parse_timestamp(start), end: _parse_timestamp(stop)}
    end
  end

  defp _parse_timestamp(timestamp) do
    timestamp
    |> String.trim("[")
    |> String.trim("]")
    |> Timex.parse!("{YYYY}-{0M}-{0D} {WDshort} {h24}:{m}")
  end



end
