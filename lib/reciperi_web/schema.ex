defmodule ReciperiWeb.Schema do
  use Absinthe.Schema
  import_types ReciperiWeb.Schema.Objects

  alias ReciperiWeb.Schema.Middleware
  alias Reciperi.Resolvers
  alias Reciperi.Resolvers.Ordering

  def middleware(middleware, field, %{identifier: :allergy_info} = object) do
    new_middleware = {Absinthe.Middleware.MapGet, to_string(field.identifier)}
    middleware
    |> Absinthe.Schema.replace_default(new_middleware, field, object)
  end

  # Pattern match only for mutations
  # Adding error handling middleware
  def middleware(middleware, _field, %{identifier: :mutation}) do
    middleware ++ [Middleware.ChangesetErrors]
  end

  def middleware(middleware, _field, _object) do
    middleware
  end

  query do
    field :me, :user do
      middleware Middleware.Authorize, :any
      resolve &Resolvers.Accounts.me/3
    end

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
      middleware Middleware.Authorize, "employee"
      resolve &Resolvers.create_ingredient/3
    end

    field :place_order, :order_result do
      arg :input, non_null(:place_order_input)
      #middleware Middleware.Authorize, :any
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

    field :login, :session do
      arg :email, non_null(:string)
      arg :password, non_null(:string)
      arg :role, non_null(:role)
      resolve &Resolvers.Accounts.login/3
      middleware fn res, _ ->
        with %{value: %{user: user}} <- res do
          %{res | context: Map.put(res.context, :current_user, user)}
        end
      end
    end
  end

  subscription do
    field :new_order, :order do
      config fn _args, %{context: context} ->
        case context[:current_user] do
          %{role: "customer", id: id} -> {:ok, topic: id}
          %{role: "employee"} -> {:ok, topic: "new_order"}
          _ ->
            {:error, "unauthorized"}
        end
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
