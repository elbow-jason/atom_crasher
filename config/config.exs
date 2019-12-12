# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :atom_crasher,
  ecto_repos: [AtomCrasher.Repo]

# Configures the endpoint
config :atom_crasher, AtomCrasherWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "YXBivg2ThNzWGbIomHh5fusYvSLsW5gwz+xla6bOeYNHWcWAdAxrQaghZHH9FDlK",
  render_errors: [view: AtomCrasherWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: AtomCrasher.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
