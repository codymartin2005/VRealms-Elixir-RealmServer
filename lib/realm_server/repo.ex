defmodule RealmServer.Repo do
  use Ecto.Repo,
    otp_app: :realm_server,
    adapter: Ecto.Adapters.Postgres
end
