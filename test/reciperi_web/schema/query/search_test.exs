defmodule ReciperiWeb.Schema.Query.SearchTest do
  use ReciperiWeb.ConnCase

  def setup do
    [conn: build_conn()]
  end

  @query """
  fragment IngredientSearchResult on Ingredient {
    name
  }
  fragment RecipeSearchResult on Recipe {
    name
    ingredients {
      name
    }
  }
  query Search($term: String!) {
    search(matching: $term) {
      ... IngredientSearchResult
      ... RecipeSearchResult
      __typename
    }
  }
  """
  @variables %{term: "e"}
  test "Search ingredients and recipes with their ingredients", context do
    insert(:ingredient, name: "Pepper")
    insert(:recipe, name: "Paella")
    response = post(
      context[:conn], "/graphql", query: @query, variables: @variables
    )
    assert %{"data" => %{"search" => results}} = json_response(response, 200)
    assert length(results) > 0
    assert Enum.find(results, &(&1["__typename"] == "Ingredient"))
    assert Enum.find(results, &(&1["__typename"] == "Recipe"))
  end
end
