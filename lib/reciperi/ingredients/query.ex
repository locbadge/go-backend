defmodule Reciperi.Ingredients.Query do
  @moduledoc """
  Functions for building ingredients queries.
  """

  import Ecto.Query
  alias Reciperi.Schemas.Ingredient
  alias Reciperi.Repo

  @doc """
  Builds a query for ingredients
  """
  @spec base_query() :: Ecto.Query.t()
  def base_query() do
    query = from ingredient in Ingredient
    {:ok, Repo.all(query)}
  end
end
