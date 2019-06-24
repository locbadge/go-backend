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

  @login """
  mutation ($email: String!, $role: Role!) {
    login(role: $role, password: "super-secret", email:$email) {
      token
    }
  }
  """
  test "new orders can be subscribed to", %{socket: socket} do
    user = insert(:user, role: "employee")
    ref = push_doc socket, @login, variables: %{
      "email" => user.email,
      "role" => "EMPLOYEE",
    }
    assert_reply ref, :ok, %{data: %{"login" => %{"token" => _}}}, 1_000

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

  test "customers can't see other customer orders", %{socket: socket} do
    ingredient = insert(:ingredient)
    customer1 = insert(:user, role: "customer")
    # login as customer1
    ref = push_doc socket, @login, variables: %{
      "email" => customer1.email,
      "role" => "CUSTOMER"
    }
    assert_reply ref, :ok, %{data: %{"login" => %{"token" => _}}}, 1_000

    # subscribe to orders
    ref = push_doc socket, @subscription
    assert_reply ref, :ok, %{subscriptionId: subscription_id}

    # customer1 places order
    place_order(customer1, ingredient)
    assert_push "subscription:data", _

    # customer2 places order
    customer2 = insert(:user, role: "customer")
    place_order(customer2, ingredient)
    refute_receive _
  end

  defp place_order(customer, ingredient) do
    input = %{"customerNumber" => 24,
      "ingredients" => [%{"quantity" => 2, "ingredientId" => ingredient.id}]
    }
    {:ok, %{data: %{"placeOrder" => _}}} = Absinthe.run(@mutation,
      ReciperiWeb.Schema, [
        context: %{current_user: customer},
        variables: %{"input" => input},
      ]
    )
  end
end
