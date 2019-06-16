defmodule ReciperiWeb.ChannelCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with channels
      use Phoenix.ChannelTest

      # The default endpoint for testing
      @endpoint ReciperiWeb.Endpoint
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Reciperi.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Reciperi.Repo, {:shared, self()})
    end

    :ok
  end
end
