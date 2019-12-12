defmodule AtomCrasher.Repo do
  use Ecto.Repo,
    otp_app: :atom_crasher,
    adapter: Ecto.Adapters.Postgres
end
