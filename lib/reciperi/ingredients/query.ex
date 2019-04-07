defmodule Reciperi.Ingredients.Query do
  @moduledoc """
  Functions for building ingredients queries, the SQL part
  """

  import Ecto.Query
  alias Reciperi.Schemas.Ingredient

  @doc """
  Builds a query for ingredients
  """
  @spec base_query() :: Ecto.Query.t()
  def base_query() do
    from ingredient in Ingredient
  end

  def where_name(query, name) do
    from ig in query,
      where: ilike(ig.name, ^"%#{name}%")
  end
end
