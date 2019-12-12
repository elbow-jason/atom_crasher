defmodule AtomCrasherWeb.PageController do
  use AtomCrasherWeb, :controller
  alias Ecto.Changeset

  defmodule AtomCreator do
    use Ecto.Schema
    alias Ecto.Changeset

    @primary_key false
    embedded_schema do
      field(:count, :integer)
    end

    def changeset(%AtomCreator{} = model \\ %AtomCreator{}, attrs) do
      model
      |> Changeset.cast(attrs, [:count])
      |> Changeset.validate_required([:count])
      |> Changeset.validate_number(:count, greater_than_or_equal_to: 0)
    end

    def blank_changeset do
      Changeset.change(%AtomCreator{})
    end
  end

  def create_atoms(conn, %{"atom_creator" => attrs}) do
    attrs
    |> AtomCreator.changeset()
    |> Changeset.apply_action(:insert)
    |> case do
      {:ok, %AtomCreator{count: count}} ->
        :ok = AtomCrasher.create_random_atoms(count)
        conn
        |> put_flash(:info, "Created #{count} atoms.")
        |> do_index(AtomCreator.blank_changeset())
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Failed to create atoms.")
        |> do_index(changeset)
    end
  end

  def index(conn, _params) do
    changeset = AtomCreator.blank_changeset()
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
