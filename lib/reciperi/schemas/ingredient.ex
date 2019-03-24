defmodule Reciperi.Schemas.Ingredient  do
  use Ecto.Schema

  @timestamps_opts [type: :utc_datetime]
  schema "reciperi_ingredients" do
    field :name, :string
    field :inserted_at, :utc_datetime
    field :updated_at, :utc_datetime
  end
end
