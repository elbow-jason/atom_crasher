defmodule AtomCrasher do
  @moduledoc """
  AtomCrasher keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def atom_limit, do: :erlang.system_info(:atom_limit)

  def atom_count, do: :erlang.system_info(:atom_count)

  def create_random_atoms(n) do
    fn -> random_string(24) end
    |> Stream.repeatedly()
    |> Stream.map(fn str -> String.to_atom(str) end)
    |> Enum.take(n)
    :ok
  end

  defp random_string(size) do
    (size * 2)
    |> :crypto.strong_rand_bytes()
    |> Base.encode64()
    |> binary_part(0, size)
  end

end
