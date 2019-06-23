defmodule ReciperiWeb.Schema.Mutation.LoginTest do
  use ReciperiWeb.ConnCase, async: true

  def setup do
    [conn: build_conn()]
  end

  @query """
  mutation ($email: String!) {
    login(role: EMPLOYEE, email:$email, password:"super-secret") {
      token
      user { name }
    }
  }
  """

  test "Creating an employee session", context do
    user = insert(:user)
    response = post(
      context[:conn], "/graphql",
      query: @query,
      variables: %{"email" => user.email}
    )
    assert %{"data" => %{
      "login" => %{
        "token" => token,
        "user" => user_data
      }
    }} = json_response(response, 200)
    assert %{"name" => user.name} == user_data
    assert {:ok, %{role: :employee, id: user.id}} ==
      ReciperiWeb.Authentication.verify(token)
  end
end
