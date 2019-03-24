defmodule ReciperiWeb.Schema do
  use Absinthe.Schema
  import_types ReciperiWeb.Schema.Ingredients

  alias ReciperiWeb.Resolvers

  query do
    @desc "Get all ingredients"
    field :ingredient, list_of(:ingredient) do
      resolve &Resolvers.Ingredient.list_ingredients/3
    end
  end
end
