defmodule Reciperi.Resolvers.Ordering do
  @moduledoc """
  The Ordering context.
  """

  import Ecto.Query, warn: false
  alias Reciperi.Repo
  alias Reciperi.Resolvers.Ordering

  alias Reciperi.Ordering.Order

  @doc """
  Creates a order.

  ## Examples

      iex> create_order(%{field: value})
      {:ok, %Order{}}

      iex> create_order(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_order(attrs \\ %{}) do
    attrs = Map.update(attrs, :ingredients, [], &build_items/1)

    %Order{}
    |> Order.changeset(attrs)
    |> Repo.insert()
  end

  defp build_items(ingredients) do
    for ing <- ingredients do
      ingredient = Reciperi.Ingredients.Query.get_item!(ing.ingredient_id)
      %{name: ingredient.name, quantity: ing.quantity, price: ingredient.price}
    end
  end

  def get_order!(id), do: Repo.get!(Order, id)

  def update_order(%Order{} = order, attrs) do
    order
    |> Order.changeset(attrs)
    |> Repo.update()
  end

  def place_order(_, %{input: place_order_input}, %{context: context}) do
    place_order_input = case context[:current_user] do
      %{role: "customer", id: id} ->
        Map.put(place_order_input, :customer_id, id)
      _ ->
        place_order_input
    end
    with {:ok, order} <- Ordering.create_order(place_order_input) do
      # TODO: investigate why `trigger` is not working
      Absinthe.Subscription.publish(
        ReciperiWeb.Endpoint,
        order,
        new_order: [order.customer_id, "new_order"]
      )
      {:ok, %{order: order}}
    end
  end

  def ready_order(_, %{id: id}, _) do
    order = Ordering.get_order!(id)
    with {:ok, order} <- Ordering.update_order(order, %{state: "ready"}) do
      {:ok, %{order: order}}
    end
  end

  def complete_order(_, %{id: id}, _) do
    order = Ordering.get_order!(id)
    with {:ok, order} <- Ordering.update_order(order, %{state: "complete"}) do
      {:ok, %{order: order}}
    end
  end
end
