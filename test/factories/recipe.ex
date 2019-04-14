defmodule Reciperi.RecipeFactory do
  defmacro __using__(_opts) do
    quote do
      def recipe_factory(attrs) do
        %Reciperi.Schemas.Recipe{
          name: Map.get(attrs, :name, "Paella")
        }
      end
    end
  end
end
