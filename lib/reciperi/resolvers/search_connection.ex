defmodule Reciperi.Resolvers.SearchConnection do
  import Ecto.Query, warn: false

  alias Reciperi.Repo
  alias Reciperi.Schemas.{Recipe, Ingredient}

  @models [Recipe, Ingredient]
  def search(term) do
    pattern = "%#{term}%"
    Enum.flat_map(@models, &search_pattern(&1, pattern))
  end

  defp search_pattern(model, pattern) do
    Repo.all(search_query(model, pattern))
  end

  defp search_query(model, pattern) when model == Recipe do
    from(
      q in model,
      where: ilike(q.name, ^pattern) or ilike(q.description, ^pattern)
    )
  end

  defp search_query(model, pattern) do
    from q in model, where: ilike(q.name, ^pattern)
  end
end
