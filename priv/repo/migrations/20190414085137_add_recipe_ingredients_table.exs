defmodule Reciperi.Repo.Migrations.AddRecipeIngredientsTable do
  use Ecto.Migration

  def change do
    create table(:reciperi_recipe_items) do
      add(:recipe_id,
        references(:reciperi_recipes, on_delete: :delete_all),
        primary_key: true
      )
      add(:ingredient_id,
        references(:reciperi_ingredients, on_delete: :delete_all),
        primary_key: true
      )

      timestamps(type: :utc_datetime, default: fragment("NOW()"))
    end

    create(index(:reciperi_recipe_items, [:recipe_id]))
    create(index(:reciperi_recipe_items, [:ingredient_id]))

    create(
      unique_index(
        :reciperi_recipe_items, [:recipe_id, :ingredient_id],
        name: :recipe_id_ingredient_id_unique_index)
    )
  end
end
