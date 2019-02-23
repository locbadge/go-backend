# Since configuration is shared in umbrella projects, this file
# should only configure the :reciperi application itself
# and only for organization purposes. All other config goes to
# the umbrella root.
use Mix.Config

# Configure your database
config :reciperi, Reciperi.Repo,
  username: System.get_env("DB_USERNAME"),
  password: System.get_env("DB_PASSWORD"),
  database: "reciperi_dev",
  hostname: "localhost",
  pool_size: 10
