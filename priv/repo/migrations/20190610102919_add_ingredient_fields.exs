defmodule Reciperi.Repo.Migrations.AddIngredientFields do
  use Ecto.Migration

  def change do
    alter table("reciperi_ingredients") do
      add :description, :text
      add :price, :decimal
    end
  end
end
