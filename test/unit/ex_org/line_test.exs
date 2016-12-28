defmodule ExOrg.LineTest do
  use ExUnit.Case

  alias ExOrg.Line
  alias ExOrg.LineTypes

  test "parse/1 blank line" do
    assert Line.parse("") == %LineTypes.Blank{}
    assert Line.parse("     ") == %LineTypes.Blank{}
    assert Line.parse("\t") == %LineTypes.Blank{}
    assert Line.parse("* headline") != %LineTypes.Blank{}
  end

  test "parse/1 headline" do
    assert Line.parse("* Level 1 Headline") == %LineTypes.Headline{level: 1, headline: "Level 1 Headline"}
    assert Line.parse("** Level 2 Headline") == %LineTypes.Headline{level: 2, headline: "Level 2 Headline"}
  end

end
