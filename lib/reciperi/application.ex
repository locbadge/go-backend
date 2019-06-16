defmodule Reciperi.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    # List all child processes to be supervised
    children = [
      supervisor(Reciperi.Repo, []),
      supervisor(ReciperiWeb.Endpoint, []),
      supervisor(Absinthe.Subscription, [ReciperiWeb.Endpoint])
    ]

    opts = [strategy: :one_for_one, name: Reciperi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ReciperiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
