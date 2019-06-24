defmodule Reciperi.Schemas.Category do
  use Ecto.Schema
  import Ecto.Changeset
  alias Reciperi.Schemas.Category


  schema "categories" do
    field :description, :string
    field :name, :string, null: false

    has_many :ingredients, Reciperi.Schemas.Ingredient

    timestamps()
  end

  @doc false
  def changeset(%Category{} = category, attrs) do
    category
    |> cast(attrs, [:description, :name])
    |> validate_required([:name])
  end
end
