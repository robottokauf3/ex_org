defmodule ExOrg.LineTypes do

  defmodule Blank,              do: defstruct [unparsed: ""]
  defmodule BlockBegin,         do: defstruct [unparsed: "", name: "", data: ""]
  defmodule BlockEnd,           do: defstruct [unparsed: "", name: ""]
  defmodule Clock,              do: defstruct [unparsed: "", timestamp: nil, duration: nil]
  defmodule Comment,            do: defstruct [unparsed: "", content: ""]
  defmodule DrawerBegin,        do: defstruct [unparsed: "", name: ""]
  defmodule DrawerEnd,          do: defstruct [unparsed: ""]
  defmodule FootnoteDefinition, do: defstruct [unparsed: "", label: "", content: ""]
  defmodule Headline,           do: defstruct [unparsed: "", level: 0, headline: "", todo: nil, priority: nil, tags: []]
  defmodule HorizontalRule,     do: defstruct [unparsed: ""]
  defmodule Keyword,            do: defstruct [unparsed: "", key: "", value: ""]
  defmodule ListItem,           do: defstruct [unparsed: "", indent: 0, content: nil]
  defmodule Text,               do: defstruct [unparsed: "", content: ""]
  defmodule TableRow,           do: defstruct [unparsed: "", cells: []]
  defmodule TableSeparator,     do: defstruct [unparsed: ""]

end
