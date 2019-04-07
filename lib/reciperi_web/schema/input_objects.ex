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
  input_object :ingredient_filters do
    @desc """
    Filter by author handle.
    """
    field :name, :string
  end
end
