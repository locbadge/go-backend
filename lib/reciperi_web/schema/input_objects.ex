defmodule ReciperiWeb.Schema.InputObjects do
  @moduledoc false

  use Absinthe.Schema.Notation

  @desc "Filtering criteria for post connections."
  input_object :ingredient_filters do
    @desc """
    Filter by author handle.
    """
    field :name, :string
  end
end
