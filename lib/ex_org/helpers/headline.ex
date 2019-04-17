defmodule ExOrg.Helpers.Headline do
  @moduledoc """
  Responsible for parsing Headline structure.

  Reference: https://orgmode.org/worg/dev/org-syntax.html#Headlines_and_Sections
  """
  alias ExOrg.LineTypes.Headline

  @default_opts [todo_keywords: ["TODO", "DONE"]]

  @doc """
  Parses headline into components.
  """
  def parse(headline, opts \\ @default_opts) do
    {tokenized_headline, _} =
      headline
      |> String.split()
      |> Enum.reduce({%Headline{}, opts}, &tokenize/2)

    tokenized_headline
  end

  defp tokenize(chunk, {st, opts}) do
    st =
      cond do
        match = Regex.run(~r/^\*+$/, chunk) ->
          [level] = match
          %{st | level: String.length(level)}

        match = Regex.run(~r/^\[#([a-zA-Z])\]$/, chunk) ->
          [_, priority] = match
          %{st | priority: priority}

        match = Regex.run(~r/^:(.*):$/, chunk) ->
          [_, tags] = match
          %{st | tags: String.split(tags, ":")}

        Enum.member?(opts[:todo_keywords], chunk) ->
          %{st | todo: chunk}

        true ->
          %{headline: headline} = st
          headline = String.trim(headline <> " " <> chunk)
          %{st | headline: headline}
      end

    {st, opts}
  end
end
