defmodule Reciperi.Repo.Migrations.AddAllergyInfoToRecipes do
  use Ecto.Migration

  def change do
    alter table(:reciperi_recipes) do
      add :allergy_info, :map
    end
  end
end
