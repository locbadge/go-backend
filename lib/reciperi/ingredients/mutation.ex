defmodule Reciperi.Ingredients.Mutation do
  @moduledoc """
  Functions for building ingredients mutations
  """

  alias Reciperi.Repo
  alias Reciperi.Schemas.Ingredient

  def create(attrs \\ %{}) do
    %Ingredient{}
      |> Ingredient.changeset(attrs)
      |> Repo.insert()
  end
end
