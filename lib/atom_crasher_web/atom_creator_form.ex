defmodule AtomCrasherWeb.AtomCreatorForm do
  use Ecto.Schema
  alias AtomCrasherWeb.AtomCreatorForm
  alias Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:count, :integer)
  end

  def changeset(%AtomCreatorForm{} = model \\ %AtomCreatorForm{}, attrs) do
    model
    |> Changeset.cast(attrs, [:count])
    |> Changeset.validate_required([:count])
    |> Changeset.validate_number(:count, greater_than_or_equal_to: 0)
  end

  def blank_changeset do
    Changeset.change(%AtomCreatorForm{})
  end
end
