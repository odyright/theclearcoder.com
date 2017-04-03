defmodule Blog.Mixfile do
  use Mix.Project

  def project do
    [
      app:               :blog,
      version:           "0.0.1",
      elixir:            "~> 1.3",
      elixirc_paths:     elixirc_paths(Mix.env),
      compilers:         [:phoenix, :gettext] ++ Mix.compilers,
      build_embedded:    Mix.env == :prod,
      start_permanent:   Mix.env == :prod,
      aliases:           aliases(),
      test_coverage:     [tool: ExCoveralls],
      deps: deps()
    ]
  end

  def application do
    [
      mod: {Blog, []},
      applications: applications(Mix.env)
    ]
  end

  defp applications(:test), do: applications(:all) ++ [:faker, :blacksmith]
  defp applications(:dev),  do: applications(:all) ++ [:faker]
  defp applications(_all),  do: [:phoenix, :phoenix_pubsub, :phoenix_html, :cowboy, :logger, 
                                 :gettext, :phoenix_ecto, :postgrex, :comeonin]

  defp elixirc_paths(:test), do: elixirc_paths(:all) ++ ["test/support"]
  defp elixirc_paths(:dev),  do: elixirc_paths(:all) ++ ["test/support/data"]
  defp elixirc_paths(_all),  do: ["lib", "web"]

  defp deps do
    [
      {:phoenix,             "1.3.0-rc.1"},
      {:phoenix_pubsub,      "~> 1.0"},
      {:phoenix_html,        "~> 2.6"},
      {:phoenix_ecto,        "~> 3.0"},
      {:postgrex,            ">= 0.0.0"},
      {:gettext,             "~> 0.11"},
      {:cowboy,              "~> 1.0"},
      {:earmark,             "~> 1.0"},
      {:comeonin,            "~> 3.0"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:excoveralls,         "~> 0.5", only: :test},
      {:faker,               "~> 0.7", only: [:dev, :test]},
      {:blacksmith,          "~> 0.1", only: [:dev, :test]}
   ]
  end

  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "test": ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
