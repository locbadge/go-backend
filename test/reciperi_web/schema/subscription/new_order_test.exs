defmodule ReciperiWeb.Schema.Subscription.NewOrderTest do
  use ReciperiWeb.SubscriptionCase

  @subscription """
  subscription {
    newOrder {
      customerNumber
    }
  }
  """

  @mutation """
  mutation ($input: PlaceOrderInput!) {
    placeOrder(input: $input) { order { id } }
  }
  """
  test "new orders can be subscribed to", %{socket: socket} do
    # Setup a subscription
    ref = push_doc socket, @subscription
    assert_reply ref, :ok, %{subscriptionId: subscription_id}

    # Mutation
    pepper = insert(:ingredient, name: "Pepper")

    order_input = %{
      "customerNumber" => 24,
      "ingredients" => [
        %{
          "quantity" => 2,
          "ingredientId" => pepper.id
        }
      ]
    }
    ref = push_doc socket, @mutation, variables: %{"input" => order_input}
    assert_reply ref, :ok, reply

    assert %{data: %{"placeOrder" => %{"order" => %{"id" => _}}}} = reply

    ## check to see if we got subscription data
    expected = %{
      result: %{data: %{"newOrder" => %{"customerNumber" => 24 }}
      },
      subscriptionId: subscription_id
    }
    assert_push "subscription:data", push
    assert expected == push
  end
end
