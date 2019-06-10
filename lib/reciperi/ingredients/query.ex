defmodule Reciperi.Ingredients.Query do
  @moduledoc """
  Functions for building ingredients queries, the SQL part
  """

  import Ecto.Query
  alias Reciperi.Repo
  alias Reciperi.Schemas.Ingredient

  @doc """
  Gets a single item.

  Raises `Ecto.NoResultsError` if the Item does not exist.

  ## Examples

      iex> get_item!(123)
      %Item{}

      iex> get_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_item!(id), do: Repo.get!(Ingredient, id)

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
      {:created_at_before, time}, query ->
        from q in query, where: q.inserted_at <= ^time
      {:created_at_after, time}, query ->
        from q in query, where: q.inserted_at >= ^time
    end)
  end

  def order_by(query, %{direction: direction, field: field}) do
    from ig in query, order_by: {^direction, ^field}
  end
end
