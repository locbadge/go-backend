defmodule ReciperiWeb.Schema.Query.MenuItemsTest do
  use ReciperiWeb.ConnCase

  def setup do
    [conn: build_conn()]
  end

  @query """
  {
    ingredients {
      name
    }
  }
  """
  test "ingredients field returns ingredient items", context do
    insert(:ingredient)
    response = get(context[:conn], "/graphql", query: @query)
    assert json_response(response, 200) == %{
      "data" => %{
        "ingredients" => [
          %{"name" => "Pepper"}
        ]
      }
    }
  end

  @query """
  {
    ingredients(
      filter: {
        name: "Foo"
      }
    ) {
      name
    }
  }
  """
  test "ingredients filtered by name foo", context do
    insert(:ingredient)
    response = get(context[:conn], "/graphql", query: @query)
    assert json_response(response, 200) == %{
      "data" => %{
        "ingredients" => []
      }
    }
  end

  @query """
  {
    ingredients(filter: { name: 123 }) {
      name
    }
  }
  """
  test "Wrong filter type", context do
    insert(:ingredient)
    response = get(context[:conn], "/graphql", query: @query)
    assert %{"errors" => [
      %{"message" => message}
    ]} = json_response(response, 200)
    assert message == "Argument \"filter\" has invalid value {name: 123}.\nIn field \"name\": Expected type \"String\", found 123."
  end
end
