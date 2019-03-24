defmodule Reciperi.Resolvers do
  @moduledoc """
  Functions for loading connections between resources, designed to be used in
  GraphQL query resolution.
  """

  import Ecto.Query, warn: false

  alias Reciperi.Resolvers.IngredientConnection

  def ingredients(parent, args, info) do
    IngredientConnection.get(parent, args, info)
  end
end
