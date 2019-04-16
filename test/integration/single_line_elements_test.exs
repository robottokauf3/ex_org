defmodule ExOrg.IntegrationTest.SingleLineElements do
  use ExUnit.Case

  alias ExOrg.LineTypes

  @fixture_root "test/fixtures/integration/"

  @expected [
    %LineTypes.Comment{unparsed: "# Comment", content: "Comment"},
    %LineTypes.Blank{unparsed: ""},
    %LineTypes.Headline{
      unparsed: "* Test Elements",
      level: 1,
      headline: "Test Elements",
      tags: [],
      todo: nil,
      priority: nil
    },
    %LineTypes.Headline{
      unparsed: "** Lists",
      level: 2,
      headline: "Lists",
      tags: [],
      todo: nil,
      priority: nil
    },
    %LineTypes.ListItem{unparsed: "- Item 1", indent: 0, content: "Item 1"},
    %LineTypes.ListItem{unparsed: "- Item 2", indent: 0, content: "Item 2"},
    %LineTypes.ListItem{unparsed: "  - Item 2.1", indent: 2, content: "Item 2.1"},
    %LineTypes.ListItem{unparsed: "  - Item 2.2", indent: 2, content: "Item 2.2"},
    %LineTypes.Headline{
      unparsed: "** Blocks",
      level: 2,
      headline: "Blocks",
      tags: [],
      todo: nil,
      priority: nil
    },
    %LineTypes.BlockBegin{unparsed: "   #+BEGIN_STUFF", name: "STUFF", data: ""},
    %LineTypes.Text{unparsed: "   Stuff contents", content: "   Stuff contents"},
    %LineTypes.BlockEnd{unparsed: "   #+END_STUFF", name: "STUFF"},
    %LineTypes.Headline{
      unparsed: "** Horizontal Rules",
      level: 2,
      headline: "Horizontal Rules",
      tags: [],
      todo: nil,
      priority: nil
    },
    %LineTypes.HorizontalRule{unparsed: "   -----"},
    %LineTypes.Headline{
      unparsed: "** Plain Text",
      level: 2,
      headline: "Plain Text",
      tags: [],
      todo: nil,
      priority: nil
    },
    %LineTypes.Text{unparsed: "   Just plain text", content: "   Just plain text"},
    %LineTypes.Headline{
      unparsed: "** Tables",
      level: 2,
      headline: "Tables",
      tags: [],
      todo: nil,
      priority: nil
    },
    %LineTypes.TableRow{unparsed: "   | H1 | H2 | H3 |", cells: ["H1", "H2", "H3"]},
    %LineTypes.TableSeparator{unparsed: "   |----+----+----|"},
    %LineTypes.TableRow{unparsed: "   | C1 | C2 | C3 |", cells: ["C1", "C2", "C3"]},
    %LineTypes.Headline{
      unparsed: "** Drawers and clocks",
      level: 2,
      headline: "Drawers and clocks",
      tags: [],
      todo: nil,
      priority: nil
    },
    %LineTypes.DrawerBegin{unparsed: "   :LOGBOOK:", name: "LOGBOOK"},
    %LineTypes.Clock{
      unparsed: "   CLOCK: [2017-01-01 Sun 23:49]",
      timestamp: %{start: ~N[2017-01-01 23:49:00], end: nil},
      duration: nil
    },
    %LineTypes.Clock{
      unparsed: "   CLOCK: [2017-01-01 Sun 23:48]--[2017-01-01 Sun 23:49] =>  0:01",
      timestamp: %{start: ~N[2017-01-01 23:48:00], end: ~N[2017-01-01 23:49:00]},
      duration: 1
    },
    %LineTypes.DrawerEnd{unparsed: "   :END:"},
    %LineTypes.Headline{
      unparsed: "** Footnotes",
      level: 2,
      headline: "Footnotes",
      tags: [],
      todo: nil,
      priority: nil
    },
    %LineTypes.Blank{unparsed: ""},
    %LineTypes.FootnoteDefinition{
      unparsed: "[fn:FOO] Contents of footnote `FOO`",
      label: "FOO",
      content: "Contents of footnote `FOO`"
    },
    %LineTypes.Headline{
      unparsed: "** Keywords",
      level: 2,
      headline: "Keywords",
      tags: [],
      todo: nil,
      priority: nil
    },
    %LineTypes.Keyword{unparsed: "#+FOO: BAR", key: "FOO", value: "BAR"}
  ]

  test "Single-line elements are parsed properly" do
    headlines =
      File.read!(@fixture_root <> "single_line_elements.org")
      |> String.trim_trailing()
      |> String.split(~r{\r\n?|\n})
      |> ExOrg.parse()

    assert headlines == @expected
  end
end
