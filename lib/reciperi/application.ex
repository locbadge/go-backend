defmodule Reciperi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      Reciperi.Repo,
      ReciperiWeb.Endpoint
    ]

    Supervisor.start_link(
      children,
      strategy: :one_for_one, name: Reciperi.Supervisor
    )
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ReciperiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
