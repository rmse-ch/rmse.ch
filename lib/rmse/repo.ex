defmodule Rmse.Repo do
  use Ecto.Repo,
    otp_app: :rmse,
    adapter: Ecto.Adapters.Postgres
end
