# Since configuration is shared in umbrella projects, this file
# should only configure the :reciperi_web application itself
# and only for organization purposes. All other config goes to
# the umbrella root.
use Mix.Config

# General application configuration
config :reciperi_web,
  ecto_repos: [Reciperi.Repo],
  generators: [context_app: :reciperi]

# Configures the endpoint
config :reciperi_web, ReciperiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "JUxiq1ujvA/zFgcmEeHhTBP9ja11KDWdkv+QZcbvJXpn4PAO0njT8xaVmT6j7FMQ",
  render_errors: [view: ReciperiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: ReciperiWeb.PubSub, adapter: Phoenix.PubSub.PG2]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
