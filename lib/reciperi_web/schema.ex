defmodule ReciperiWeb.Schema do
  use Absinthe.Schema
  import_types ReciperiWeb.Schema.Objects

  alias Reciperi.Resolvers
  alias Reciperi.Resolvers.Ordering

  query do
    @desc "A list of ingredients ."
    field :ingredients, list_of(:ingredient) do
      @desc "Filtering criteria for ingredients."
      arg :filter, :ingredient_filter
      arg :order, :ingredient_order

      resolve &Resolvers.ingredients/3
    end

    field :recipes, list_of(:recipe) do
      resolve &Resolvers.recipes/3
    end

    field :search, list_of(:search_result) do
      arg :matching, non_null(:string)
      resolve &Resolvers.search/3
    end
  end

  mutation do
    field :create_ingredient, :ingredient_result do
      arg :input, non_null(:ingredient_input)
      resolve &Resolvers.create_ingredient/3
    end

    field :place_order, :order_result do
      arg :input, non_null(:place_order_input)
      resolve &Ordering.place_order/3
    end
    field :ready_order, :order_result do
      arg :id, non_null(:id)
      resolve &Ordering.ready_order/3
    end

    field :complete_order, :order_result do
      arg :id, non_null(:id)
      resolve &Ordering.complete_order/3
    end
  end

  subscription do
    field :new_order, :order do
      config fn _args, _info ->
        {:ok, topic: "*"}
      end
    end

    field :update_order, :order do
      arg :id, non_null(:id)
      config fn args, _info ->
        {:ok, topic: args.id}
      end

      trigger [:ready_order, :complete_order], topic: fn
        %{order: order} -> [order.id]
        _ -> []
      end

      resolve fn %{order: order}, _ , _ ->
        {:ok, order}
      end
    end
  end
end
