defmodule Reciperi.Resolvers.Accounts do
  alias Reciperi.Accounts

  def login(_, %{email: email, password: password, role: role}, _) do
    case Accounts.authenticate(role, email, password) do
      {:ok, user} ->
        token = ReciperiWeb.Authentication.sign(%{
          role: role, id: user.id
        })
      {:ok, %{token: token, user: user}}
      _ ->
        {:error, "incorrect email or password"}
    end
  end
end
