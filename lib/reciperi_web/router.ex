defmodule ReciperiWeb.Router do
  use ReciperiWeb, :router

  pipeline :graphql do
    plug :accepts, ["json"]
    plug ReciperiWeb.Context
  end

  scope "/" do
    pipe_through :graphql

    forward(
      "/graphql",
      Absinthe.Plug,
      json_codec: Jason,
      schema: ReciperiWeb.Schema
    )

    forward(
      "/graphiql",
      Absinthe.Plug.GraphiQL,
      json_codec: Jason,
      schema: ReciperiWeb.Schema,
      socket: ReciperiWeb.UserSocket
    )
  end
end
