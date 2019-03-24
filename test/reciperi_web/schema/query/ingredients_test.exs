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
    request = get context[:conn], "/graphql", query: @query
    assert json_response(request, 200) == %{
      "data" => %{
        "ingredients" => [
          %{"name" => "Pepper"}
        ]
      }
    }
  end

  # @query """
  # {
  #   ingredients(matching: "foo"){
  #     name
  #   }
  # }
  # """
  # test "ingredients field returns ingredient items" do
  #   conn = get conn, "/graphql", query: @query
  #   assert json_response(conn, 200) == %{
  #     "data" => %{
  #       "ingredients" => []
  #     }
  #   }
  # end
end
