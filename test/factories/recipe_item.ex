defmodule Reciperi.RecipeItemFactory do
  defmacro __using__(_opts) do
    quote do
      def recipe_item_factory(attrs) do
        %Reciperi.Schemas.RecipeItem{
          recipe_id: Map.get(attrs, :recipe_id),
          ingredient_id: Map.get(attrs, :ingredient_id)
        }
      end
    end
  end
end
