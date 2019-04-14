defmodule ReciperiWeb.Schema.Objects do
  use Absinthe.Schema.Notation

  alias Reciperi.Resolvers
  import_types ReciperiWeb.Schema.Enums
  import_types ReciperiWeb.Schema.Scalars
  import_types ReciperiWeb.Schema.InputObjects
  import_types ReciperiWeb.Schema.Fragments

  @desc "Igredient definition"
  object :ingredient do
    interfaces [:search_result]
    field :id, :id
    field :name, :string
  end

  @desc "These are the relation between a recipe and an ingredient"
  object :recipe_item do
    field :id, :id
    field :ingredient_id, :id
    field :name, :string do
      resolve fn recipe_item, _, _ ->
        {:ok, recipe_item.ingredient.name }
      end
    end
  end

  @desc "Recipe definition"
  object :recipe do
    interfaces [:search_result]
    field :name, :string
    field :description, :string
    field :ingredients, list_of(:recipe_item) do
      resolve &Resolvers.ingredients_for_recipe/3
    end
  end

  @desc "Search interface to search recipes or ingredients"
  interface :search_result do
    field :name, :string
    resolve_type fn
      %Reciperi.Schemas.Ingredient{}, _ ->
        :ingredient
      %Reciperi.Schemas.Recipe{}, _ ->
        :recipe
      _, _ ->
        nil
    end
  end
end
