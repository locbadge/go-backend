defmodule ReciperiWeb.Schema.Query.IngredientsTest do
  use ReciperiWeb.ConnCase

  @filter_query """
  query ($filter: IngredientFilter) {
    ingredients(filter: $filter) {
      name
    }
  }
  """
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
    insert(:ingredient, name: "Pepper")
    response = get(context[:conn], "/graphql", query: @query)
    assert json_response(response, 200) == %{
      "data" => %{
        "ingredients" => [
          %{"name" => "Pepper"}
        ]
      }
    }
  end

  @variables %{filter: %{"name" => "Foo"}}
  test "ingredients filtered by name foo", context do
    insert(:ingredient)
    response = post(
      context[:conn], "/graphql", query: @filter_query, variables: @variables
    )
    assert json_response(response, 200) == %{
      "data" => %{
        "ingredients" => []
      }
    }
  end

  @variables %{filter: %{"createdAtBefore" => "2015-06-24T04:50:34Z"}}
  test "ingredients filtered by created_at_before", context do
    {:ok, datetime, 0} = DateTime.from_iso8601("2015-01-23T23:50:07Z")
    insert(:ingredient, %{inserted_at: datetime})
    response = post(
      context[:conn], "/graphql", query: @filter_query, variables: @variables
    )
    assert json_response(response, 200) == %{
      "data" => %{
        "ingredients" => [
          %{"name" => "Pepper"}
        ]
      }
    }
  end

  @variables %{filter: %{"createdAtAfter" => "2015-06-24T04:50:34Z"}}
  test "ingredients filtered by created_at_after", context do
    {:ok, datetime, 0} = DateTime.from_iso8601("2015-08-23T23:50:07Z")
    insert(:ingredient, %{inserted_at: datetime})
    response = post(
      context[:conn], "/graphql", query: @filter_query, variables: @variables
    )
    assert json_response(response, 200) == %{
      "data" => %{
        "ingredients" => [
          %{"name" => "Pepper"}
        ]
      }
    }
  end
  @variables %{filter: %{"createdAtBefore" => "not-a-datetime"}}
  test "wrong created_at_before datetime format", context do
    response = post(
      context[:conn], "/graphql", query: @filter_query, variables: @variables
    )
    assert %{"errors" => [%{"message" => message}]} = json_response(
      response, 200
    )
    expected = """
    Argument "filter" has invalid value $filter.
    In field "createdAtBefore": Expected type "Time", found "not-a-datetime".\
    """
    assert expected == message
  end

  @query """
  query ($order: OrderDirection) {
    ingredients(order: {direction: $order}) {
      name
    }
  }
  """
  @variables %{"order" => "DESC"}
  test "Ordered ingredients", context do
    insert(:ingredient, name: "Apple")
    insert(:ingredient)
    response = post(context[:conn], "/graphql", query: @query, variables: @variables)
    assert json_response(response, 200) == %{
      "data" => %{
        "ingredients" => [
          %{"name" => "Pepper"},
          %{"name" => "Apple"}
        ]
      }
    }
  end

  @variables %{filter: %{"name" => 123}}
  test "Wrong filter type", context do
    insert(:ingredient)
    response = post(
      context[:conn], "/graphql", query: @filter_query, variables: @variables
    )
    assert %{"errors" => [%{"message" => message}]} = json_response(
      response, 200
    )
    assert message == "Argument \"filter\" has invalid value $filter.\nIn field \"name\": Expected type \"String\", found 123."
  end
end
