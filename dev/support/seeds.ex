defmodule Reciperi.Seeds do
  def run() do
    alias Reciperi.{Repo}
    alias Reciperi.Schemas.{Ingredient}

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
