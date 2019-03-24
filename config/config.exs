# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :reciperi,
  ecto_repos: [Reciperi.Repo]

# Configures the endpoint
config :reciperi, ReciperiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "kNLrouPCVoZpDAyrruxRuRtSu2hhJ/drHPGkwEak4shqr1v/1fHQitM0QG0Exk/N",
  render_errors: [view: ReciperiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Reciperi.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
