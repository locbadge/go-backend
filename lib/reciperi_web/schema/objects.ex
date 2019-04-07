defmodule ReciperiWeb.Schema.Objects do
  use Absinthe.Schema.Notation

  import_types ReciperiWeb.Schema.Enums
  import_types ReciperiWeb.Schema.Scalars
  import_types ReciperiWeb.Schema.InputObjects

  @desc "Igredient definition"
  object :ingredient do
    field :id, :id
    field :name, :string
  end
end
