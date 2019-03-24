defmodule Reciperi.Ingredient  do
  use Ecto.Schema
  # import Ecto.Query

  alias Reciperi.{Repo}

  @timestamps_opts [type: :utc_datetime]
  schema "reciperi_ingredients" do
    field :name, :string
    field :inserted_at, :utc_datetime
    field :updated_at, :utc_datetime
  end

  def list_ingredients do
    Repo.all(Reciperi.Ingredient)
  end
end
