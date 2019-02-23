# Since configuration is shared in umbrella projects, this file
# should only configure the :reciperi application itself
# and only for organization purposes. All other config goes to
# the umbrella root.
use Mix.Config

config :reciperi,
  ecto_repos: [Reciperi.Repo]

import_config "#{Mix.env()}.exs"
