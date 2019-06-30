### TODO
- [ ] Book page: 220: Integrating with a frontend
- [ ] Add [nginx support for websockets](https://www.nginx.com/blog/websocket-nginx/)


### Nginx support Websockets
```
proxy_http_version 1.1;
proxy_set_header Upgrade $http_upgrade;
proxy_set_header Connection "Upgrade";
```
# Resolution strategies
In a GraphQL document how we can avoid N+1 queries?

- Page 176 -> `async`: It doesn't avoid N+1 queries but pospone execution and do all the queries
in parallel not serial. This strategy is more helpful for external services calls.

- Page 181 -> `batch`: The problem with async, of course, is that while it's faster than serial database queries,
we're still doing N of them to get N categories when we could really be doing just one database query to get all the categories

- Page 184 -> `Dataloader`: An evolution of `batch` plugin. This is the standard way of avoiding N+1 queries in GraphQL.
If in some situations you need to do very hand crafted SQL `batch` can be better option.
In general the way of increasing performance in Absinthe is using `Dataloader`.

### Debug
To setup a debugger do this in the code you want to debug:
```
require IEx; IEx.pry
```

Debug has to happen on an interactive session `IEX`.To run
a test with a file that has a debugger do this:
```
iex -S mix test
```

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
