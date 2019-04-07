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

  def where_filter(query, filter) do
    Enum.reduce(filter, query, fn
      {:name, name}, query ->
        from q in query, where: ilike(q.name, ^"%#{name}%")
    end)
  end

  def order_by(query, %{direction: direction, field: field}) do
    from ig in query, order_by: {^direction, ^field}
  end
end
