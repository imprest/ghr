defmodule Ghr.Repo do
  use Ecto.Repo,
    otp_app: :ghr,
    adapter: Ecto.Adapters.Postgres
end
