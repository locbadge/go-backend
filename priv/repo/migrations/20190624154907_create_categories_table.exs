defmodule Reciperi.Repo.Migrations.CreateCategoriesTable do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :description, :string
      add :name, :string, null: false

      timestamps()
    end
  end
end
