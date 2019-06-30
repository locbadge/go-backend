defmodule Reciperi.Resolvers.IngredientConnection do
  import Ecto.Query, warn: false
  import Absinthe.Resolution.Helpers, only: [on_load: 2]

  alias Reciperi.Schemas.Ingredient
  alias Reciperi.Ingredients
  alias Reciperi.Repo
  alias Reciperi.Resolvers.IngredientConnection

  def list_items(args) do
    args
    |> items_query
    |> Repo.all
  end

  defp items_query(args) do
    Enum.reduce(args, Ingredient, fn
      {:order, order}, query ->
        query
        |> order_by({^order, :name})
      {:filter, filter}, query ->
        query |> filter_with(filter)
    end)
  end

  def data() do
    Dataloader.Ecto.new(Repo, query: &query/2)
  end

  def query(Ingredient, args) do
    items_query(args)
  end

  def query(queryable, _) do
    queryable
  end

  def get(parent, args, _context) do
    query =
      build_base_query(parent)
      |> filter_with(args)
      |> order(args)

    # This is here to maintain an interface compatible
    # with a pagination system like the one in https://github.com/levelhq/leve
    {:ok, Repo.all(query)}
  end

  def create(params) do
    with {:ok, ingredient} <- Ingredients.Mutation.create(params) do
      {:ok, %{ingredient: ingredient}}
    end
  end

  def ingredients_for_category(category, args, %{context: %{loader: loader}}) do
    loader
    |> Dataloader.load(IngredientConnection, {:ingredients, args}, category)
    |> on_load(fn loader ->
      ingredients = Dataloader.get(loader, IngredientConnection, {:ingredients, args}, category)
      {:ok, ingredients}
    end)
  end

  def category_for_ingredient(ingredient, _, %{context: %{loader: loader}}) do
    loader
    |> Dataloader.load(IngredientConnection, :category, ingredient)
    |> on_load(fn loader ->
      category = Dataloader.get(loader, IngredientConnection, :category, ingredient)
      {:ok, category}
    end)
  end

  defp build_base_query(_parent) do
    Ingredients.Query.base_query()
  end

  defp filter_with(base_query, %{filter: filter}) do
    Ingredients.Query.where_filter(base_query, filter)
  end

  defp filter_with(base_query, _), do: base_query

  defp order(base_query, %{order: order}) do
    Ingredients.Query.order_by(base_query, order)
  end

  defp order(base_query, _), do: base_query
end
