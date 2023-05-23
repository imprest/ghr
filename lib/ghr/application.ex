defmodule Ghr.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      GhrWeb.Telemetry,
      # Start the Ecto repository
      Ghr.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Ghr.PubSub},
      # Start Finch
      {Finch, name: Ghr.Finch},
      # Start Presence
      GhrWeb.Presence,
      # Start the Endpoint (http/https)
      GhrWeb.Endpoint
      # Start a worker by calling: Ghr.Worker.start_link(arg)
      # {Ghr.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Ghr.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    GhrWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
