defmodule RmseWeb.LinksLive do
  alias Rmse.Links.{LinkCollection, Link}
  alias Rmse.Links

  use RmseWeb, :live_view

  @impl true
  def handle_params(_params, uri, socket) do
    {:noreply, assign_request_path(socket, uri)}
  end

  @impl true
  def mount(_params, _session, socket) do
    # TODO: move this the database for more comfort
    tool_sections = Links.list_link_collections()

    {:ok,
     socket
     |> assign(:page_title, gettext("Links - Rico Metzger"))
     |> assign(:tool_sections, tool_sections)}
  end

  def title(_lang, nil), do: nil
  def title("de", %Link{title_de: title_de}), do: title_de
  def title(_lang, %Link{title_en: title_en}), do: title_en
  def title("de", %LinkCollection{name_de: title_de}), do: title_de
  def title(_lang, %LinkCollection{name_en: title_en}), do: title_en

  def description(_lang, nil), do: nil
  def description("de", %Link{description_de: description_de}), do: description_de
  def description(_lang, %Link{description_en: description_en}), do: description_en
end
