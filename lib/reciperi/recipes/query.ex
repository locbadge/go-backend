defmodule Reciperi.Recipes.Query do
  @moduledoc """
  Functions for building ingredients queries, the SQL part
  """

  import Ecto.Query
  alias Reciperi.Schemas.Recipe

  @doc """
  Builds a query for recipes
  """
  def base_query() do
    from recipe in Recipe
  end
end
