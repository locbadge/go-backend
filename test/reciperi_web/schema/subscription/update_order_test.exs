defmodule ReciperiWeb.Schema.Subscription.UpdateOrderTest do
  use ReciperiWeb.SubscriptionCase

  @subscription """
  subscription ($id: ID!) {
    updateOrder(id: $id) { state }
  }
  """

  @mutation """
  mutation ($id: ID!) {
    readyOrder(id: $id) { errors { message } }
  }
  """
  test "Subscribe to orders updates", %{socket: socket} do
    pepper = insert(:ingredient, name: "Pepper")
    order1 = insert(
      :order,
      customer_number: 23,
      ingredients: [
        %{price: pepper.price, quantity: 2, name: pepper.name}
      ]
    )
    order2 = insert(
      :order,
      customer_number: 24,
      ingredients: [
        %{price: pepper.price, quantity: 5, name: pepper.name}
      ]
    )

    ref = push_doc(socket, @subscription, variables: %{"id" => order1.id})
    assert_reply ref, :ok, %{subscriptionId: _subscription_ref1}

    ref = push_doc(socket, @subscription, variables: %{"id" => order2.id})
    assert_reply ref, :ok, %{subscriptionId: subscription_ref2}

    ref = push_doc(socket, @mutation, variables: %{"id" => order2.id})
    assert_reply ref, :ok, reply

    refute reply[:errors]
    refute reply[:data]["readyOrder"]["errors"]

    assert_push "subscription:data", push
    expected = %{
      result: %{data: %{"updateOrder" => %{"state" => "ready"}}},
      subscriptionId: subscription_ref2
    }
    assert expected == push
  end
end
