defmodule Reciperi.Repo.Migrations.AddAllergyInfoToIngredients do
  use Ecto.Migration

  def change do
    alter table(:reciperi_ingredients) do
      add :allergy_info, :map
    end
  end
end
