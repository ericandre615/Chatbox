# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :chatbox,
  ecto_repos: [Chatbox.Repo]

# Configures the endpoint
config :chatbox, Chatbox.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "lii8PBX6BzSaFppECx/vY0lD2iH2S+3poQSkd5q8RTTY6kbWm0QTv52QQH/JeSNt",
  render_errors: [view: Chatbox.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Chatbox.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
