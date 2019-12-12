defmodule AtomCrasherWeb.AtomCreationLive do
  use Phoenix.LiveView
  use Phoenix.HTML

  alias AtomCrasherWeb.AtomCreatorForm
  alias Ecto.Changeset

  def render(assigns) do
    ~L"""
      <section class="phx-hero">
        <h1>Welcome to Atom Crasher</h1>
        <p>There are currently <%= @atom_count %> atoms and the limit is <%= @atom_limit %></p>
      </section>

      <section class="row">
        <button phx-click="add" phx-value-count="1">Add 1 Atom</button>
        &nbsp;
        <button phx-click="add" phx-value-count="10">Add 10 Atoms</button>
        &nbsp;
        <button phx-click="add" phx-value-count="1000">Add 1000 Atoms</button>
        &nbsp;
        <button phx-click="add" phx-value-count="1000000">Add 1 Million Atoms</button>
        &nbsp;
        <button phx-click="add" phx-value-count="fill">Fill up atom table</button>
      </section>
    """
  end

  def mount(%{}, socket) do
    {:ok, update_assigns(socket)}
  end

  def handle_event("add", %{"count" => "fill"}, socket) do
    :ok = AtomCrasher.create_random_atoms(remaining_atoms())
    {:noreply, update_assigns(socket)}
  end

  def handle_event("add", %{"count" => num}, socket) do
    :ok =
      num
      |> String.to_integer()
      |> AtomCrasher.create_random_atoms()

    {:noreply, update_assigns(socket)}
  end

  defp remaining_atoms do
    AtomCrasher.atom_limit() - AtomCrasher.atom_count()
  end

  def update_assigns(socket) do
    assign(socket,
      atom_count: AtomCrasher.atom_count(),
      atom_limit: AtomCrasher.atom_limit()
    )
  end
end
