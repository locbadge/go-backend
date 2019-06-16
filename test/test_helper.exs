ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Reciperi.Repo, :manual)

# Factories
{:ok, _} = Application.ensure_all_started(:ex_machina)
