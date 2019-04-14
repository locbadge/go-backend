defmodule ReciperiWeb.Schema.InputObjects do
  @moduledoc false

  use Absinthe.Schema.Notation

  @desc "The field and direction to sort ingredients."
  input_object :ingredient_order do
    @desc "The field by which to sort."
    field :field, non_null(:ingredient_order_field), default_value: :name

    @desc "The sort direction."
    field :direction, non_null(:order_direction), default_value: :desc
  end

  @desc "Filtering criteria for post connections."
  input_object :ingredient_filter do
    field :name, :string
    @desc "Filter by created before"
    field :created_at_before, :time
    @desc "Filter by created after"
    field :created_at_after, :time
  end

  @desc "Ingredient's accepted fields on mutation"
  input_object :ingredient_input do
    field :name, non_null(:string)
  end
end
