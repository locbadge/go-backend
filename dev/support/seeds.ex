defmodule Reciperi.Seeds do
  def run() do
    alias Reciperi.{Repo}
    alias Reciperi.Schemas.{Ingredient}
    alias Reciperi.Accounts.{User}

    %User{}
      |> User.changeset(%{
        name: "Hellen",
        email: "hellen@reciperi.com",
        password: "super-secret",
        role: "employee"
      })
      |> Repo.insert!

    %Ingredient{
      name: "Pepper",
      description: "Something here",
      price: 3.50,
      allergy_info: [
        %{"allergen" => "Alergy1", "severity" => "Contains"},
        %{"allergen" => "Alergy2", "severity" => "Shared Equipment"},
      ]
    } |> Repo.insert!

    :ok
  end
end
