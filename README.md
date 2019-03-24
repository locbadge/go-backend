## Console
This way iex load project dependencies
```
source .env && iex -S mix
```

## Migrations
There are 2 alias in `apps/reciperi/mix.ex` to update `apps/reciperi/priv/repor/structure.sql` each time we do migrate up/down
List migrations
```
mix db.list -r Reciperi.Repo
```

Run migrations AKA `bin/rails db:migrate:up`
```
mix db.up -n 1 -r Reciperi.Repo
```

Rollback (n is the versions to rollback) AKA `bin/rails db:migrate:down`
```
mix db.down -n 1 -r Reciperi.Repo
```

## Connect to PostgreSQL in console
Copy DB_PASSWORD from .env file, `psql` command will ask for it>
```
 cat .env
psql -U development -W --dbname reciperi_dev --host localhost
```

## TODO
- [ ] Investigate why is necessary to `source .env` before running console
