defmodule ExOrg.LineTest do
  use ExUnit.Case

  alias ExOrg.Line
  alias ExOrg.LineTypes

  @line_tests [
    # Blank Lines
    {"", %LineTypes.Blank{unparsed: ""}},
    {" ", %LineTypes.Blank{unparsed: ""}},
    {"\t", %LineTypes.Blank{unparsed: ""}},

    # Block - Begin
    {"#+BEGIN_FOO", %LineTypes.BlockBegin{name: "FOO"}},
    {"#+BEGIN_FOO BAR", %LineTypes.BlockBegin{name: "FOO", data: "BAR"}},

    # Block - End
    {"#+END_FOO", %LineTypes.BlockEnd{name: "FOO"}},

    # Clock
    {"CLOCK:", %LineTypes.Clock{timestamp: nil, duration: nil}},
    {"CLOCK: [2016-12-30 Fri 02:16]",
     %LineTypes.Clock{timestamp: "[2016-12-30 Fri 02:16]", duration: nil}},
    {"CLOCK: [2016-12-30 Fri 02:16]--[2016-12-30 Fri 02:17] =>  0:01",
     %LineTypes.Clock{timestamp: "[2016-12-30 Fri 02:16]--[2016-12-30 Fri 02:17]", duration: "0:01"}},

    # Comment
    {"# FOOBAR", %LineTypes.Comment{content: "FOOBAR"}},
    {"   # FOOBAR", %LineTypes.Comment{content: "FOOBAR"}},
    {"   #    FOOBAR", %LineTypes.Comment{content: "FOOBAR"}},

    # Drawer - Begin
    {":FOO_BAR:", %LineTypes.DrawerBegin{name: "FOO_BAR"}},

    # Drawer - End
    {":END:", %LineTypes.DrawerEnd{}},

    # Footnote Definition
    {"[fn:1] bar", %LineTypes.FootnoteDefinition{label: "1", content: "bar"}},
    {"[fn:one_two] bar", %LineTypes.FootnoteDefinition{label: "one_two", content: "bar"}},

    # Headline
    {"* Level 1 Headline", %LineTypes.Headline{level: 1, headline: "Level 1 Headline"}},
    {"** Level 2 Headline", %LineTypes.Headline{level: 2, headline: "Level 2 Headline"}},

    # HorizontalRule

    {"-----", %LineTypes.HorizontalRule{}},
    {"-----------", %LineTypes.HorizontalRule{}},

    # Keyword
    {"#+FOO: BAR", %LineTypes.Keyword{key: "FOO", value: "BAR"}},

    # ListItem

    {"1. foo", %LineTypes.ListItem{indent: 0, content: "foo"}},
    {"- foo", %LineTypes.ListItem{indent: 0, content: "foo"}},
    {"  - foo", %LineTypes.ListItem{indent: 2, content: "foo"}},
    {"    + foo", %LineTypes.ListItem{indent: 4, content: "foo"}},

    # Table
    {"| foo | bar |", %LineTypes.Table{content: "| foo | bar |"}},

    # Text
    {"I am plain text", %LineTypes.Text{content: "I am plain text"}},
    {"I have^#(*&$^#(&*^$))crazy\tcharacters!", %LineTypes.Text{content: "I have^#(*&$^#(&*^$))crazy\tcharacters!"}},
  ]

  for {text, expected} <- @line_tests do
    test("line: '" <> text <> "'") do
      line_type = %{unquote(Macro.escape expected) | unparsed: unquote(text)}
      assert Line.parse(unquote(text)) == line_type
    end
  end
end
