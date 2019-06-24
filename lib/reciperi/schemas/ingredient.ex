defmodule Reciperi.Schemas.Ingredient  do
  use Ecto.Schema
  import Ecto.Changeset

  alias Reciperi.Schemas.RecipeItem
  alias Reciperi.Schemas.Ingredient

  @timestamps_opts [type: :utc_datetime]
  schema "reciperi_ingredients" do
    field :name, :string
    field :description, :string
    field :price, :decimal
    field :allergy_info, {:array, :map}
    has_many(:recipes, RecipeItem)
    belongs_to :category, Reciperi.Schemas.Category

    field :inserted_at, :utc_datetime
    field :updated_at, :utc_datetime
  end

  @doc false
  def changeset(%Ingredient{} = ingredient, attrs) do
    ingredient
    |> cast(attrs, [:name, :description, :price])
    |> validate_required([:name, :price])
    |> unique_constraint(:name)
  end

end
