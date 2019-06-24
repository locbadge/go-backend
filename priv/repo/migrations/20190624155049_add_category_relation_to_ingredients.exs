defmodule Reciperi.Repo.Migrations.AddCategoryRelationToIngredients do
  use Ecto.Migration

  def change do
    alter table(:reciperi_ingredients) do
      add :category_id, references(:categories)
    end

  end
end
