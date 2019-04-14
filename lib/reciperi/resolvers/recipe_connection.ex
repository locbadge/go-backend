defmodule Reciperi.Resolvers.RecipeConnection do
  import Ecto.Query, warn: false

  alias Reciperi.Recipes
  alias Reciperi.Repo

  def get(parent, _args, _context) do
    query = build_base_query(parent)
    {:ok, Repo.all(query)}
  end

  defp build_base_query(_parent) do
    Recipes.Query.base_query()
  end
end
