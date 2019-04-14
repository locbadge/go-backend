defmodule Reciperi.Schemas.Recipe  do
  use Ecto.Schema

  alias Reciperi.Schemas.RecipeItem

  @timestamps_opts [type: :utc_datetime]
  schema "reciperi_recipes" do
    field :name, :string
    field :description, :string
    has_many(:ingredients, RecipeItem)

    field :inserted_at, :utc_datetime
    field :updated_at, :utc_datetime
  end
end
