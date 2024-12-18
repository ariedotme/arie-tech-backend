defmodule AriexTechBackend.Repo do
  use Ecto.Repo,
    otp_app: :ariex_tech_backend,
    adapter: Ecto.Adapters.Postgres
end
