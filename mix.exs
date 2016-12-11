defmodule ExOrg.Mixfile do
  use Mix.Project

  @version "0.1.0"

  def project do
    [app: :ex_org,
     version: @version,
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     package: package()]
  end

  def application do
    [applications: []]
  end

  defp deps do
    []
  end

  defp package do
    [maintainers: ["Robert Kaufmann III <rok3@rok3.me>"],
     licenses: ["MIT"],
     links: %{github: "https://github.com/robottokauf3/ex_org"}
    ]
  end

  defp description do
    """
    Parsing Library for Org mode documents.
    """
  end
end
