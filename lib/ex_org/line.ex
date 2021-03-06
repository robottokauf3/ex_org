defmodule ExOrg.Line do
  @moduledoc """
  Match line types and parse into structs
  """

  alias ExOrg.{Helpers, LineTypes}

  @blank_regex ~r/^\s*$/
  @block_begin_regex ~r/^\s*#\+BEGIN_(\S*)(\s*|\s+.*)$/
  @block_end_regex ~r/^\s*#\+END_(\S+)\s*$/
  @clock_regex ~r/^\s*CLOCK:\s*(\[.+\])?\s*(=>\s+(\d{1,2}:\d{1,2}))?$/
  @comment_regex ~r/^\s*#\s+(.*)$/
  @drawer_begin_regex ~r/^\s*:([-_a-z0-9]+):\s*$/i
  @drawer_end_regex ~r/^\s*:END:\s*$/
  @footnote_definition_regex ~r/^\[fn:([0-9]+|\S+)\]\s+(.*)$/
  @headline_regex ~r/^\*+\s+.+$/
  @horizontal_rule_regex ~r/^\s*-{5,}$/
  @keyword_regex ~r/^#\+(\S+):\s*(.*)$/

  @list_item_regex ~r/^(\s*)([-+]|[0-9]+\.)\s+(.*)$/
  @table_separator_regex ~r/^\s*\|-.*$/
  @table_row_regex ~r/^\s*(\|.*\|)\s*$/

  @doc """
  Parses a line into a line type .
  """
  def parse(line) do
    line
    |> String.trim_trailing()
    |> _parse()
    |> Map.put(:unparsed, line)
  end

  # credo:disable-for-next-line Credo.Check.Refactor.CyclomaticComplexity
  defp _parse(line) do
    cond do
      Regex.run(@blank_regex, line) ->
        %LineTypes.Blank{}

      Regex.run(@horizontal_rule_regex, line) ->
        %LineTypes.HorizontalRule{}

      Regex.run(@drawer_end_regex, line) ->
        %LineTypes.DrawerEnd{}

      match = Regex.run(@block_begin_regex, line) ->
        [_, name, content] = match
        %LineTypes.BlockBegin{name: name, data: String.trim(content)}

      match = Regex.run(@block_end_regex, line) ->
        [_, name] = match
        %LineTypes.BlockEnd{name: name}

      match = Regex.run(@drawer_begin_regex, line) ->
        [_, name] = match
        %LineTypes.DrawerBegin{name: name}

      match = Regex.run(@list_item_regex, line) ->
        [_, indent, _, content] = match
        %LineTypes.ListItem{indent: String.length(indent), content: content}

      Regex.run(@headline_regex, line) ->
        Helpers.Headline.parse(line)

      match = Regex.run(@comment_regex, line) ->
        [_, content] = match
        %LineTypes.Comment{content: content}

      match = Regex.run(@keyword_regex, line) ->
        [_, key, value] = match
        %LineTypes.Keyword{key: key, value: value}

      match = Regex.run(@clock_regex, line) ->
        Helpers.Clock.parse(match)

      match = Regex.run(@footnote_definition_regex, line) ->
        [_, label, content] = match
        %LineTypes.FootnoteDefinition{label: label, content: content}

      Regex.run(@table_separator_regex, line) ->
        %LineTypes.TableSeparator{}

      match = Regex.run(@table_row_regex, line) ->
        [_, content] = match
        Helpers.Table.parse(content)

      true ->
        %LineTypes.Text{content: line}
    end
  end
end
