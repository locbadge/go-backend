defmodule Reciperi.Resolvers do
  @moduledoc """
  Functions for loading connections between resources, designed to be used in
  GraphQL query resolution.
  """

  import Ecto.Query, warn: false

  alias Reciperi.Resolvers.IngredientConnection
  alias Reciperi.Resolvers.RecipeConnection
  alias Reciperi.Resolvers.RecipeItemConnection
  alias Reciperi.Resolvers.SearchConnection

  def ingredients(parent, args, info) do
    IngredientConnection.get(parent, args, info)
  end

  def create_ingredient(parent, args, info) do
    IngredientConnection.create(parent, args, info)
  end

  def recipes(parent, args, info) do
    RecipeConnection.get(parent, args, info)
  end

  def ingredients_for_recipe(recipe, args, info) do
    RecipeItemConnection.for_recipe(recipe, args, info)
  end

  def search(_, %{matching: term}, _) do
    {:ok, SearchConnection.search(term)}
  end
end
