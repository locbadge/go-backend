defmodule ReciperiWeb.Schema.Ingredients do
  use Absinthe.Schema.Notation

  object :ingredient do
    field :id, :id
    field :name, :string
  end
end
