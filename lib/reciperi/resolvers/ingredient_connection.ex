defmodule Reciperi.Resolvers.IngredientConnection do
  import Ecto.Query, warn: false

  alias Reciperi.Ingredients
  alias Reciperi.Repo

  def get(parent, args, _context) do
    query =
      build_base_query(parent)
      |> filter_with(args)
      |> order(args)

    # This is here to maintain an interface compatible
    # with a pagination system like the one in https://github.com/levelhq/leve
    {:ok, Repo.all(query)}
  end

  def create(params) do
    with {:ok, ingredient} <- Ingredients.Mutation.create(params) do
      {:ok, %{ingredient: ingredient}}
    end
  end

  defp build_base_query(_parent) do
    Ingredients.Query.base_query()
  end

  defp filter_with(base_query, %{filter: filter}) do
    Ingredients.Query.where_filter(base_query, filter)
  end

  defp filter_with(base_query, _), do: base_query

  defp order(base_query, %{order: order}) do
    Ingredients.Query.order_by(base_query, order)
  end

  defp order(base_query, _), do: base_query
end
