defmodule Reciperi.Resolvers.RecipeItemConnection do
  import Ecto.Query, warn: false

  alias Reciperi.RecipeItems
  alias Reciperi.Repo

  def for_recipe(recipe, _args, _context) do
    query = RecipeItems.Query.base_query(recipe)
    {:ok, Repo.all(query)}
  end
end
