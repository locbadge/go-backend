defmodule Reciperi.UserFactory do
  defmacro __using__(_opts) do
    quote do
      def user_factory(attrs) do
        int = :erlang.unique_integer([:positive, :monotonic])
        %Reciperi.Accounts.User{
          name: Map.get(attrs, :name, "Paco-#{int}"),
          email: Map.get(attrs, :email, "paco-#{int}@merlo.io"),
          password: "super-secret",
          role: Map.get(attrs, :role, "employee")
        }
      end
    end
  end
end
