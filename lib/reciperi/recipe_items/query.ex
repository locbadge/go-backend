defmodule Reciperi.RecipeItems.Query do
  @moduledoc """
  Functions for building recipe items queries, the SQL part
  """

  import Ecto.Query
  alias Reciperi.Schemas.RecipeItem

  @doc """
  Builds a query for recipe item
  """
  def base_query(recipe) do
    query = build_query()
    from recipe_item in query, where: recipe_item.recipe_id == ^recipe.id
  end

  def base_query() do
    build_query()
  end

  defp build_query() do
    from recipe_item in RecipeItem, preload: [:ingredient]
  end
end
