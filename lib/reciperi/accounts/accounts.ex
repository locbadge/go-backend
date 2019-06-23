
defmodule Reciperi.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Reciperi.Repo
  alias Comeonin.Ecto.Password

  alias Reciperi.Accounts.User

  def lookup(role, id) do
    Repo.get_by(User, role: to_string(role), id: id)
  end

  def authenticate(role, email, password) do
    user = Repo.get_by(User, role: to_string(role), email: email)

    with %{password: digest} <- user,
    true <- Password.valid?(password, digest) do
      {:ok, user}
    else
      _ -> :error
    end
  end
end
