defmodule ExOrg.Line do

  @moduledoc """
  Match line types and parse into structs
  """

  alias ExOrg.LineTypes

  @blank_regex ~r/^\s*$/
  @block_begin_regex ~r/^\s*#\+BEGIN_(\S*)(\s*|\s+.*)$/
  @block_end_regex ~r/^\s*#\+END_(\S+)\s*$/
  @clock_regex ~r/^\s*CLOCK:\s*(\[.+\])?\s*(=>\s+(\d{1,2}:\d{1,2}))?$/ #TODO Support other timestamp formats
  @comment_regex ~r/^\s*#\s+(.*)$/
  @drawer_begin_regex ~r/^\s*:([-_a-z0-9]+):\s*$/i
  @drawer_end_regex ~r/^\s*:END:\s*$/
  @footnote_definition_regex ~r/^\[fn:([0-9]+|\S+)\]\s+(.*)$/
  @headline_regex ~r/^(\*+)\s+(.+)$/
  @horizontal_rule_regex ~r/^\s*-{5,}$/
  @keyword_regex ~r/^#\+(\S+):\s*(.*)$/

  @list_item_regex ~r/^(\s*)([-+]|[0-9]+\.)\s+(.*)$/
  @table_regex ~r/^\s*(\|.*\|)\s*$/

  def parse(line) do

    line
    |> String.trim_trailing
    |> _parse()
    |> Map.put(:unparsed, line)

  end

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

       match = Regex.run(@headline_regex, line) ->
        [_, level_pips, headline] = match
        %LineTypes.Headline{level: String.length(level_pips), headline: headline}

      match = Regex.run(@comment_regex, line) ->
        [_, content] = match
        %LineTypes.Comment{content: content}

      match = Regex.run(@keyword_regex, line) ->
        [_, key, value] = match
        %LineTypes.Keyword{key: key, value: value}

      match = Regex.run(@clock_regex, line) ->
        case match do
          [_, timestamp, _, duration] ->
            %LineTypes.Clock{timestamp: timestamp, duration: duration}
          [_, timestamp] ->
            %LineTypes.Clock{timestamp: timestamp}
          [_] ->
            %LineTypes.Clock{}
        end

      match = Regex.run(@footnote_definition_regex, line) ->
        [_, label, content] = match
        %LineTypes.FootnoteDefinition{label: label, content: content}

      match = Regex.run(@table_regex, line) ->
        [_, content] = match
        %LineTypes.Table{content: content}

      true ->
        %LineTypes.Text{content: line}
    end
  end

end
