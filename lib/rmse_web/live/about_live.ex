defmodule RmseWeb.AboutLive do
  use RmseWeb, :live_view

  import RmseWeb.SocialIconsComponent

  @impl true
  def handle_params(_params, uri, socket) do
    {:noreply, assign_request_path(socket, uri)}
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :page_title, gettext("About - Rico Metzger"))}
  end
end
