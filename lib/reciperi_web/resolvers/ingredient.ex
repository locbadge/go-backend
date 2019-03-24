defmodule ReciperiWeb.Resolvers.Ingredient do
  def list_ingredients(_parent, _args, _resolution) do
    {:ok, Reciperi.Ingredient.list_ingredients()}
  end
end
