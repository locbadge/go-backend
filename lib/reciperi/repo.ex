defmodule Reciperi.Repo do
  use Ecto.Repo,
    otp_app: :reciperi,
    adapter: Ecto.Adapters.Postgres
end
