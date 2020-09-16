# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :realm_server,
  ecto_repos: [RealmServer.Repo]

# Configures the endpoint
config :realm_server, RealmServerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Mro/829WQYRY8pq+1G1qpXjJY3tucK5J/Rw7ljN1XEwZvkdcQpuFuI8zwtFaTMQN",
  render_errors: [view: RealmServerWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: RealmServer.PubSub,
  live_view: [signing_salt: "s0TTGq8f"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
