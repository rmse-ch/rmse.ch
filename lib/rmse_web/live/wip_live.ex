defmodule RmseWeb.WIPLive do
  use RmseWeb, :live_view

  @impl true
  def handle_params(_params, uri, socket) do
    {:noreply,
     socket
     |> assign_request_path(uri)
     |> assign(:page_title, title(socket.assigns[:live_action]))}
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :page_title, title(socket.assigns[:live_action]))}
  end

  defp title(:blog), do: gettext("Blog - Rico Metzger")
  defp title(:agb), do: gettext("AGB - Rico Metzger")
  defp title(:cookies), do: gettext("Cookies - Rico Metzger")
  defp title(:projects), do: gettext("Projects - Rico Metzger")
  defp title(:apps), do: gettext("Apps - Rico Metzger")
  defp title(:contact), do: gettext("Contact - Rico Metzger")

  defp title(atom) do
    dynamic_title =
      atom
      |> Atom.to_string()
      |> String.capitalize()

    "#{dynamic_title} - Rico Metzger"
  end
end
