use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :reciperi, ReciperiWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :reciperi, Reciperi.Repo,
  username: System.get_env("DB_USERNAME"),
  password: System.get_env("DB_PASSWORD"),
  database: "reciperi_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
