defmodule Reciperi.Repo.Migrations.AddRecipesTable do
  use Ecto.Migration

  def change do
    create table("reciperi_recipes") do
      add :name, :string
      add :description, :text

      timestamps(type: :utc_datetime, default: fragment("NOW()"))
    end
  end
end
