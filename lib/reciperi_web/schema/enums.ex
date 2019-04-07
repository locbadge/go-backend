defmodule ReciperiWeb.Schema.Enums do
  @moduledoc false

  use Absinthe.Schema.Notation

  enum :ingredient_order_field do
    value :name
  end

  enum :order_direction do
    value :asc
    value :desc
  end
end
