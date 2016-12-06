use Mix.Config

# For production, we configure the host to read the PORT
# from the system environment. Therefore, you will need
# to set PORT=80 before running your server.
#
# You should also configure the url host to something
# meaningful, we use this information when generating URLs.
#
# Finally, we also include the path to a manifest
# containing the digested version of static files. This
# manifest is generated by the mix phoenix.digest task
# which you typically run after static files are built.
config :blog, Blog.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [scheme: "https", host: "www.theclearcoder.com", port: 443],
  force_ssl: [rewrite_on: [:x_forwarded_proto]], 
  cache_static_manifest: "priv/static/manifest.json",
  secret_key_base: System.get_env("SECRET_KEY_BASE")

# Do not print debug messages in production
config :logger, level: :info

config :blog, Blog.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
  ssl: true

# Production values for Comeonin
config :comeonin,
  bcrypt_log_rounds: 14,
  pbkdf2_rounds: 120_000
