defmodule RmseWeb.BlogLive.Index do
  alias Rmse.Blog
  use RmseWeb, :live_view

  @impl true
  def handle_params(params, uri, socket) do
    {:noreply,
     socket
     |> assign_request_path(uri)
     |> assign_page(params)}
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:articles, [])
     |> assign(:page_title, gettext("Blog - Rico Metzger"))
     |> assign(:more?, false)}
  end

  @impl true
  def handle_event("show_page", %{"page" => page}, socket) do
    {:noreply, push_patch(socket, to: ~p"/blog?page=#{page}")}
  end

  defp assign_page(socket, %{"page" => page_param}) do
    {page, ""} = Integer.parse(page_param)
    assign(socket, :page, page) |> load_articles(page)
  end

  defp assign_page(socket, _params), do: assign(socket, :page, 0) |> load_articles(0)

  defp load_articles(socket, page) do
    articles = Blog.list_articles(page)
    more? = Enum.count(articles) > 20

    socket
    |> assign(:articles, articles)
    |> assign(:more?, more?)
  end
end
