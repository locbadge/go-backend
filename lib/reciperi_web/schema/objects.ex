defmodule ReciperiWeb.Schema.Objects do
  use Absinthe.Schema.Notation

  @desc "Igredient definition"
  object :ingredient do
    field :id, :id
    field :name, :string
  end
end
