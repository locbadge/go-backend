defmodule Reciperi.Seeds do
  def run() do
    alias Reciperi.{Repo}
    alias Reciperi.Schemas.{Ingredient, Category}
    alias Reciperi.Accounts.{User}

    %User{}
      |> User.changeset(%{
        name: "Hellen",
        email: "hellen@reciperi.com",
        password: "super-secret",
        role: "employee"
      })
      |> Repo.insert!

    %User{}
      |> User.changeset(%{
        name: "Bob",
        email: "bob@gmail.com",
        password: "super-secret",
        role: "customer"
      })
      |> Repo.insert!


    hortalizas_category = %Category{
      name: "Hortalizas",
      description: "Something here",
    } |> Repo.insert!
    %Ingredient{
      name: "Pepper",
      description: "Something here",
      price: 3.50,
      category_id: hortalizas_category.id,
      allergy_info: [
        %{"allergen" => "Alergy1", "severity" => "Contains"},
        %{"allergen" => "Alergy2", "severity" => "Shared Equipment"},
      ]
    } |> Repo.insert!

    seeds_category = %Category{
      name: "Seeds",
      description: "Semillas",
    } |> Repo.insert!
    %Ingredient{
      name: "Almond",
      description: "Frutito seco",
      price: 2.30,
      category_id: seeds_category.id,
      allergy_info: []
    } |> Repo.insert!

    :ok
  end
end
