defmodule Reciperi.Factory do
  use ExMachina.Ecto, repo: Reciperi.Repo
  use Reciperi.IngredientFactory
  use Reciperi.RecipeFactory
  use Reciperi.RecipeItemFactory
  use Reciperi.OrderFactory
end
