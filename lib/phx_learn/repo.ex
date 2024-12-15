defmodule PhxLearn.Repo do
  use Ecto.Repo,
    otp_app: :phx_learn,
    adapter: Ecto.Adapters.Postgres
end
