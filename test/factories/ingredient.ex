defmodule Reciperi.IngredientFactory do
  defmacro __using__(_opts) do
    quote do
      def ingredient_factory do
        now = DateTime.utc_now()
        %Reciperi.Ingredient{
          name: "Pepper",
          inserted_at: now,
          updated_at: now
        }
      end
    end
  end
end
