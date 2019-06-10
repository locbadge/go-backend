defmodule Reciperi.OrderingTest do
  use ReciperiWeb.ConnCase

  alias Reciperi.Ordering

  describe "orders" do
    alias Reciperi.Ordering.Order

    test "create_order/1 with valid data creates a order" do
      chai = insert(:ingredient, name: "Masala Chai", price: "10.3")
      fries = insert(:ingredient, name: "French Fries", price: "4.0")
      attrs = %{
        ordered_at: "2010-04-17 14:00:00.000000Z",
        customer_number: 10,
        state: "created",
        ingredients: [
          %{ingredient_id: chai.id, quantity: 1},
          %{ingredient_id: fries.id, quantity: 2}
        ]
      }

      assert {:ok, %Order{} = order} = Ordering.create_order(attrs)
      assert Enum.map(order.ingredients,
        &Map.take(&1, [:name, :quantity, :price])
      ) == [
        %{name: "Masala Chai", quantity: 1, price: chai.price},
        %{name: "French Fries", quantity: 2, price: fries.price}
      ]
      assert order.state == "created"
    end

    #test "create_order/1 with invalid data returns error changeset" do
    #  assert {:error, %Ecto.Changeset{}} = Ordering.create_order(@invalid_attrs)
    #end
  end
end
