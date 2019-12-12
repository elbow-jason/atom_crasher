defmodule AtomCrasher do
  @moduledoc """
  AtomCrasher keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  require Logger

  def atom_limit, do: :erlang.system_info(:atom_limit)

  def atom_count, do: :erlang.system_info(:atom_count)

  def create_random_atoms(n) when is_integer(n) and n >= 0 do
    :ok = Logger.debug("""
    Adding #{n} atoms...
      count_before: #{atom_count()}
      limit: #{atom_limit()}
    """)
    fn -> random_string(24) end
    |> Stream.repeatedly()
    |> Stream.with_index(1)
    |> Stream.map(fn {str, index} ->
      _ = String.to_atom(str)
      if rem(index, 1000) == 0 do
        Logger.debug("Added #{index}...")
      end
      :ok
    end)
    |> Enum.take(n)

    :ok = Logger.debug("""
    Added #{n} total atoms...
      count_after: #{atom_count()}
      limit: #{atom_limit()}
    """)

    :ok
  end

  defp random_string(size) do
    (size * 2)
    |> :crypto.strong_rand_bytes()
    |> Base.encode64()
    |> binary_part(0, size)
  end
end
