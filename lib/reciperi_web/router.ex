defmodule ReciperiWeb.Router do
  use ReciperiWeb, :router

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
    interface: :simple,
    socket: ReciperiWeb.UserSocket
  )
end
