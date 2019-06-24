defmodule ReciperiWeb.Schema.Objects do
  use Absinthe.Schema.Notation

  alias Reciperi.Resolvers
  import_types ReciperiWeb.Schema.Enums
  import_types ReciperiWeb.Schema.Scalars
  import_types ReciperiWeb.Schema.InputObjects
  import_types ReciperiWeb.Schema.Fragments

  @desc "An error encountered trying to persist input"
  object :result_error do
    field :key, non_null(:string)
    field :message, non_null(:string)
  end

  object :order_item do
    field :name, :string
    field :quantity, :integer
  end

  object :order do
    field :id, :id
    field :customer_number, :integer
    field :ingredients, list_of(:order_item)
    field :state, :string
  end

  object :order_result do
    field :order, :order
    field :errors, list_of(:result_error)
  end

  object :allergy_info do
    field :allergen, :string
    field :severity, :string
  end

  @desc "Igredient definition"
  object :ingredient do
    interfaces [:search_result]
    field :id, :id
    field :name, :string
    field :description, :string
    field :price, :decimal
    field :allergy_info, list_of(:allergy_info)
  end

  object :ingredient_result do
    field :ingredient, :ingredient
    field :errors, list_of(:result_error)
  end

  interface :user do
    field :email, :string
    field :name, :string
    resolve_type fn
      %{role: "employee"}, _ -> :employee
      %{role: "customer"}, _ -> :customer
    end
  end

  object :employee do
    interface :user
    field :email, :string
    field :name, :string
  end

  object :customer do
    interface :user
    field :email, :string
    field :name, :string
    field :orders, list_of(:order) do
      resolve fn customer, _, _ ->
        import Ecto.Query

        orders =
          Reciperi.Ordering.Order
          |> where(customer_id: ^customer.id)
          |> Reciperi.Repo.all

        {:ok, orders}
      end
    end
  end

  object :session do
    field :token, :string
    field :user, :user
  end

  @desc "These are the relation between a recipe and an ingredient"
  object :recipe_item do
    field :id, :id
    field :ingredient_id, :id
    field :name, :string do
      resolve fn recipe_item, _, _ ->
        {:ok, recipe_item.ingredient.name }
      end
    end
  end

  @desc "Recipe definition"
  object :recipe do
    interfaces [:search_result]
    field :name, :string
    field :description, :string
    field :ingredients, list_of(:recipe_item) do
      resolve &Resolvers.ingredients_for_recipe/3
    end
  end

  @desc "Search interface to search recipes or ingredients"
  interface :search_result do
    field :name, :string
    resolve_type fn
      %Reciperi.Schemas.Ingredient{}, _ ->
        :ingredient
      %Reciperi.Schemas.Recipe{}, _ ->
        :recipe
      _, _ ->
        nil
    end
  end
end
