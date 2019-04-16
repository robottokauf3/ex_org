defmodule ExOrg.Mixfile do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :ex_org,
      version: @version,
      description: description(),
      elixir: "~> 1.4",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package()
    ]
  end

  def application do
    [applications: [:timex]]
  end

  defp deps do
    [
      {:timex, "~> 3.0"},

      # Testing and documentation
      {:credo, "~> 1.0.4", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0.0-rc.6", only: [:dev], runtime: false}
    ]
  end

  defp package do
    [
      maintainers: ["Robert Kaufmann III <rok3@rok3.me>"],
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
