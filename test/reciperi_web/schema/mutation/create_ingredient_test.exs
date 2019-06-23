defmodule ReciperiWeb.Schema.Mutation.CreateIngredientTest do
  use ReciperiWeb.ConnCase, async: true

  @query """
  mutation ($ingredient: IngredientInput!) {
    createIngredient(input: $ingredient) {
      errors { key message }
      ingredient {
        name
        description
        price
      }
    }
  }
  """
  @variables %{ingredient: %{
    "name" => "Onion",
    "description" => "Allium cepa, is an herbaceous biennial in the family Liliaceae grown for its edible bulb. The stem of the plant is a flattened disc at the base and the tubular leaves form a pseudostem where their sheaths overlap",
    "price" => "1.30"
  }}
  test "createIngredient field creates an ingredient", context do
    variables = @variables
    conn = context[:conn] |> auth_conn
    response = post(conn, "/graphql", query: @query, variables: variables)
    data = %{
      "data" => %{
        "createIngredient" => %{
          "errors" => nil,
          "ingredient" => %{
            "name" => variables[:ingredient]["name"],
            "description" => variables[:ingredient]["description"],
            "price" => variables[:ingredient]["price"]
          }
        }
      }
    }
    assert json_response(response, 200) == data
  end

  @variables %{ingredient: %{"name" => "Onion", "price" => "1.30"}}
  test "must be authorized as an employee to create an ingredient", context do
    customer = insert(:user, role: "customer")
    conn = context[:conn] |> auth_conn(customer)
    response = post(conn, "/graphql", query: @query, variables: @variables)
    data = %{
      "data" => %{ "createIngredient" => nil},
      "errors" => [
        %{
          "locations" => [%{"column" => 0, "line" => 2}],
          "message" => "unauthorized",
          "path" => ["createIngredient"]
        }
      ]
    }
    assert json_response(response, 200) == data
  end

  @variables %{ingredient: %{"name" => "Onion", "price" => "1.30"}}
  test "createIngredient with existing field fails", context do
    variables = @variables
    insert(:ingredient, name: "Onion")
    conn = context[:conn] |> auth_conn
    response = post(conn, "/graphql", query: @query, variables: variables)
    assert json_response(response, 200) == %{
      "data" => %{
        "createIngredient" => %{
          "ingredient" => nil,
          "errors" => [
            %{"key" => "name", "message" => "has already been taken"}
          ]
        }
      }
    }
  end
end
