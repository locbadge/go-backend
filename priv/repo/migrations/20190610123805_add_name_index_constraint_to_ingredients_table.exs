defmodule Reciperi.Repo.Migrations.AddNameIndexConstraintToIngredientsTable do
  use Ecto.Migration

  def change do
    create unique_index(:reciperi_ingredients, [:name])
  end
end
