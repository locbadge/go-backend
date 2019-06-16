defmodule ReciperiWeb.SubscriptionCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      import Reciperi.Factory

      # Import conveniences for testing with channels
      use ReciperiWeb.ChannelCase
      use(
        Absinthe.Phoenix.SubscriptionTest,
        schema: ReciperiWeb.Schema
      )
      setup do
        {:ok, socket} = Phoenix.ChannelTest.connect(ReciperiWeb.UserSocket, %{})
        {:ok, socket} = Absinthe.Phoenix.SubscriptionTest.join_absinthe(socket)
        {:ok, socket: socket}
      end
    end
  end
end
