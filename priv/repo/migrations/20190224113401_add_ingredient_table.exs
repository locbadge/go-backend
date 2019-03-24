defmodule Core.Repo.Migrations.AddIngredientTable do
  use Ecto.Migration

  def change do
    create table("reciperi_ingredients") do
      add :name,    :string, size: 40

      timestamps(type: :utc_datetime, default: fragment("NOW()"))
    end
  end
end
