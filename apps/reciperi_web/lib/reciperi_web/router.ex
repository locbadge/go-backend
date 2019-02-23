defmodule ReciperiWeb.Router do
  use ReciperiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ReciperiWeb do
    pipe_through :api
  end
end
