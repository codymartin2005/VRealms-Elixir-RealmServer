defmodule RealmServer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      RealmServer.Repo,
      # Start the Telemetry supervisor
      RealmServerWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: RealmServer.PubSub},
      # Start the Endpoint (http/https)
      RealmServerWeb.Endpoint,
      {Registry, keys: :unique, name: RealmServer.RealmInstanceRegistry},
      {DynamicSupervisor, strategy: :one_for_one, name: RealmServer.RealmInstanceSupervisor}

      # Start a worker by calling: RealmServer.Worker.start_link(arg)
      # {RealmServer.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RealmServer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    RealmServerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
