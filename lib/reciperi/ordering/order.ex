defmodule Reciperi.Ordering.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field :customer_number, :integer
    field :ordered_at, :utc_datetime
    field :state, :string
    embeds_many :ingredients, Reciperi.Ordering.Ingredient

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    require IEx; IEx.pry
    order
    |> cast(attrs, [:customer_number, :ordered_at, :state])
    |> cast_embed(:ingredients)
    |> validate_required([:customer_number, :ingredients, :ordered_at, :state])
  end
end
