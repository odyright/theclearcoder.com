# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

config :blog,
  ecto_repos: [Blog.Repo]

# Configures the endpoint
config :blog, Blog.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "rMB57c4S2vu6d2qcpNb1KuiUrGyrzbRp9vPQur7ZUrRv9vpIS+sMtDK/Sr3aukUi",
  render_errors: [view: Blog.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Blog.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Setup dev/test parameters for Comeonin
config :comeonin,
  bcrypt_log_rounds: 4,
  pbkdf2_rounds: 1_000
  
# let's encrypt values for dev/test
config :blog, :lets_encrypt,
  state:    "ON",
  response: "1234567890abcdef"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
