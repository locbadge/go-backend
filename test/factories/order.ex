defmodule Reciperi.OrderFactory do
  defmacro __using__(_opts) do
    quote do
      def order_factory(attrs) do
        %Reciperi.Ordering.Order{
          ingredients: Map.get(attrs, :ingredients, []),
        }
      end
    end
  end
end
