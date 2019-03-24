defmodule Reciperi.Resolvers.IngredientConnection do
  import Ecto.Query, warn: false

  alias Reciperi.Ingredients

  def get(parent, _args, _context) do
    build_base_query(parent)
  end

  defp build_base_query(_parent) do
    Ingredients.Query.base_query()
  end
end
