defmodule ReciperiWeb.Schema.Query.MenuItemsTest do
  use ReciperiWeb.ConnCase

  @query """
  {
    ingredients {
      name
    }
  }
  """
  test "ingredients field returns ingredient items" do
    insert(:ingredient)
    conn = build_conn()
    conn = get conn, "/graphql", query: @query
    assert json_response(conn, 200) == %{
      "data" => %{
        "ingredients" => [
          %{"name" => "Pepper"},
        ]
      }
    }
  end

end
