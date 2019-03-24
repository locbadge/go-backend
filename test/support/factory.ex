defmodule Reciperi.Factory do
  use ExMachina.Ecto, repo: Reciperi.Repo
  use Reciperi.IngredientFactory
end
