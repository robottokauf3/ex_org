defmodule ExOrg.LineTypes do

  defmodule Blank,    do: defstruct []
  defmodule Headline, do: defstruct [level: 0, headline: ""]
  defmodule Unknown,  do: defstruct [content: ""]

end
