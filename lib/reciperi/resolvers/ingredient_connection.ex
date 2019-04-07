defmodule Reciperi.Resolvers.IngredientConnection do
  import Ecto.Query, warn: false

  alias Reciperi.Ingredients
  alias Reciperi.Repo

  def get(parent, args, _context) do
    require IEx; IEx.pry
    query =
      build_base_query(parent)
      |> filter_by(args)

    # This is here to maintain an interface compatible
    # with a pagination system like the one in https://github.com/levelhq/leve
    {:ok, Repo.all(query)}
  end

  defp build_base_query(_parent) do
    Ingredients.Query.base_query()
  end

  defp filter_by(base_query, %{filter: %{name: name}}) do
    Ingredients.Query.where_name(base_query, name)
  end

  defp filter_by(base_query, _), do: base_query
end
