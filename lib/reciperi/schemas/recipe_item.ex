defmodule Reciperi.Schemas.RecipeItem do
  use Ecto.Schema

  alias Reciperi.Schemas.Recipe
  alias Reciperi.Schemas.Ingredient

  @timestamps_opts [type: :utc_datetime]
  schema "reciperi_recipe_items" do
    belongs_to(:recipe, Recipe)
    belongs_to(:ingredient, Ingredient)

    field :inserted_at, :utc_datetime
    field :updated_at, :utc_datetime
  end
end
