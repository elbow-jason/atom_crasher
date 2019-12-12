defmodule AtomCrasherWeb.PageController do
  use AtomCrasherWeb, :controller
  alias Ecto.Changeset
  alias AtomCrasherWeb.AtomCreatorForm

  def create_atoms(conn, %{"atom_creator_form" => attrs}) do
    attrs
    |> AtomCreatorForm.changeset()
    |> Changeset.apply_action(:insert)
    |> case do
      {:ok, %AtomCreatorForm{count: count}} ->
        :ok = AtomCrasher.create_random_atoms(count)

        conn
        |> put_flash(:info, "Created #{count} atoms.")
        |> do_index(AtomCreatorForm.blank_changeset())

      {:error, changeset} ->
        conn
        |> put_flash(:error, "Failed to create atoms.")
        |> do_index(changeset)
    end
  end

  def index(conn, _params) do
    changeset = AtomCreatorForm.blank_changeset()
    do_index(conn, changeset)
  end

  defp do_index(conn, changeset) do
    assigns = [
      atom_count: AtomCrasher.atom_count(),
      atom_limit: AtomCrasher.atom_limit(),
      changeset: changeset
    ]

    render(conn, "index.html", assigns)
  end
end
