defmodule ExOrg.Helpers.ClockTest do
  use ExUnit.Case

  alias ExOrg.Helpers.Clock

  test "duration_in_minutes/1 returns duration in minutes" do
    assert Clock.duration_in_minutes("00:00") == 0
    assert Clock.duration_in_minutes("00:01") == 1
    assert Clock.duration_in_minutes("42:42") == 2562
  end

  test "parse_timestamp/1" do
    start_datetime = ~N[2017-01-01 01:01:00]
    end_datetime = ~N[2017-02-02 02:02:00]

    assert Clock.parse_timestamp("[2017-01-01 Sun 01:01]") == %{start: start_datetime, end: nil}

    assert Clock.parse_timestamp("[2017-01-01 Sun 01:01]--[2017-02-02 Thu 02:02]") == %{
             start: start_datetime,
             end: end_datetime
           }
  end
end
