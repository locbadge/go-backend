defmodule Reciperi.Resolvers.IngredientConnection do
  import Ecto.Query, warn: false

  alias Reciperi.Ingredients
  alias Reciperi.Repo

  def get(parent, args, _context) do
    query =
      build_base_query(parent)
      |> filter_with(args)
      |> order(args)

    # This is here to maintain an interface compatible
    # with a pagination system like the one in https://github.com/levelhq/leve
    {:ok, Repo.all(query)}
  end

  def create(_, %{input: params}, _) do
    case Ingredients.Mutation.create(params) do
      {:error, changeset} ->
        {:ok, %{errors: transform_errors(changeset)}}
      {:ok, ingredient} ->
        {:ok, %{ingredient: ingredient}}
    end
  end

  def transform_errors(changeset) do
    changeset
    |> Ecto.Changeset.traverse_errors(&format_error/1)
    |> Enum.map(fn
      {key, value} -> %{key: key, message: value}
    end)
  end

  @spec format_error(Ecto.Changeset.error) :: String.t
  defp format_error({msg, opts}) do
    Enum.reduce(opts, msg, fn {key, value}, acc ->
      String.replace(acc, "%{#{key}}", to_string(value))
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
