defmodule Reciperi.Ordering.Ingredient do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :price, :decimal
    field :name, :string
    field :quantity, :integer
  end

  def changeset(ingredient, attrs) do
    ingredient
    |> cast(attrs, [:price, :name, :quantity])
    |> validate_required([:price, :name, :quantity])
  end
end
