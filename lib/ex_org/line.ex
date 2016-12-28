defmodule ExOrg.Line do

  alias ExOrg.LineTypes

  @blank_regex ~r/^\s*$/
  @headline_regex ~r/^(\*+)\s+(.+)$/

  def parse(line) do

    cond do
      Regex.run(@blank_regex, line) ->
        %LineTypes.Blank{}

      [_, level_pips, headline] = Regex.run(@headline_regex, line) ->
        %LineTypes.Headline{level: String.length(level_pips), headline: headline}

      true ->
        %LineTypes.Unknown{content: line}
    end
  end

end
