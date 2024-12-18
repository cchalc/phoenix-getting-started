defmodule PhxLearn.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PhxLearnWeb.Telemetry,
      PhxLearn.Repo,
      {DNSCluster, query: Application.get_env(:phx_learn, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PhxLearn.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: PhxLearn.Finch},
      # Start a worker by calling: PhxLearn.Worker.start_link(arg)
      # {PhxLearn.Worker, arg},
      # Start to serve requests, typically the last entry
      PhxLearnWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhxLearn.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhxLearnWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
