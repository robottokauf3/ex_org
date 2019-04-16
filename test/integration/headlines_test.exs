defmodule ExOrg.IntegrationTest.Headlines do
  use ExUnit.Case

  alias ExOrg.LineTypes

  @fixture_root "test/fixtures/integration/"

  @expected [
    %LineTypes.Headline{unparsed: "* Level 1 Headline", level: 1, headline: "Level 1 Headline"},
    %LineTypes.Headline{unparsed: "** Level 2 Headline", level: 2, headline: "Level 2 Headline"},
    %LineTypes.Headline{unparsed: "*** Level 3 Headline", level: 3, headline: "Level 3 Headline"},
    %LineTypes.Headline{
      unparsed: "**** Level 4 Headline",
      level: 4,
      headline: "Level 4 Headline"
    },
    %LineTypes.Blank{}
  ]

  test "Headlines are parsed and nested properly" do
    headlines =
      File.read!(@fixture_root <> "headlines.org")
      |> String.split(~r{\r\n?|\n})
      |> ExOrg.parse()

    assert headlines == @expected
  end
end
