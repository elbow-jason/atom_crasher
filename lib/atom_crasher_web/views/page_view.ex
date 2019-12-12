defmodule AtomCrasherWeb.PageView do
  use AtomCrasherWeb, :view

  def atom_creation_live_form_action() do
    Routes.live_path(AtomCrasherWeb.Endpoint, AtomCrasherWeb.AtomCreationLive)
  end
end
