use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :blog, Blog.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# configure database
config :blog, Blog.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "blog_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# add the following config to speed up tests
config :comeonin, :bcrypt_log_rounds, 4 
config :comeonin, :pbkdf2_rounds, 1
