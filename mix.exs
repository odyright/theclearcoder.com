defmodule Blog.Mixfile do
  use Mix.Project

  def project do
    [app:               :blog,
     version:           "0.0.1",
     elixir:            "~> 1.3",
     elixirc_paths:     elixirc_paths(Mix.env),
     compilers:         [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded:    Mix.env == :prod,
     start_permanent:   Mix.env == :prod,
     aliases:           aliases(),
     test_coverage:     [tool: ExCoveralls],
     preferred_cli_env: [
       "coveralls": :test,
       "coveralls.detail": :test,
       "coveralls.post": :test,
       "coveralls.html": :test
     ],
     deps: deps()]
  end

  def application do
    [mod: {Blog, []},
     applications: [:phoenix, :phoenix_pubsub, :phoenix_html, :cowboy, :logger, 
                    :gettext, :phoenix_ecto, :postgrex, :comeonin]]
  end

  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  defp deps do
    [
      {:phoenix,             "~> 1.2.1"},
      {:phoenix_pubsub,      "~> 1.0"},
      {:phoenix_html,        "~> 2.6"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:phoenix_ecto,        "~> 3.0"},
      {:postgrex,            ">= 0.0.0"},
      {:gettext,             "~> 0.11"},
      {:cowboy,              "~> 1.0"},
      {:excoveralls,         "~> 0.5", only: :test},
      {:earmark,             "~> 1.0"},
      {:comeonin,            "~> 2.0"}
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
