defmodule Biomex.Mixfile do
  use Mix.Project

  def project do
    [app: :biomex,
     version: "0.0.1",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [
      mod: {Biomex, []},
      applications: [:logger, :timex]
    ]
  end

  defp deps do
    [
      {:noise, git: "https://github.com/joshforisha/noise"},
      {:png, git: "https://github.com/yuce/png.git"},
      {:timex, "~> 3.0"}
    ]
  end
end
