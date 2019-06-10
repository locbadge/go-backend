defmodule ReciperiWeb.Schema do
  use Absinthe.Schema
  import_types ReciperiWeb.Schema.Objects

  alias Reciperi.Resolvers

  query do
    @desc "A list of ingredients ."
    field :ingredients, list_of(:ingredient) do
      @desc "Filtering criteria for ingredients."
      arg :filter, :ingredient_filter
      arg :order, :ingredient_order

      resolve &Resolvers.ingredients/3
    end

    field :recipes, list_of(:recipe) do
      resolve &Resolvers.recipes/3
    end

    field :search, list_of(:search_result) do
      arg :matching, non_null(:string)
      resolve &Resolvers.search/3
    end
  end

  mutation do
    field :create_ingredient, :ingredient_result do
      arg :input, non_null(:ingredient_input)
      resolve &Resolvers.create_ingredient/3
    end
  end
end
