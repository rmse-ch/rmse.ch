defmodule RmseWeb.BlogLive.Show do
  require Logger

  alias Rmse.Blog.Article
  alias Rmse.Blog
  use RmseWeb, :live_view

  @impl true
  def handle_params(params, uri, socket) do
    {:noreply,
     socket
     |> assign_request_path(uri)
     |> assign_slug(params)}
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:article, nil)
     |> assign(:page_title, nil)}
  end

  defp assign_slug(socket, %{"slug" => slug}) do
    update_socket_with_article(socket, slug, Blog.get_article_by_slug(slug))
  end

  defp update_socket_with_article(socket, slug, nil) do
    socket
    |> assign(:slug, slug)
    |> assign(:article, nil)
    |> assign_content(nil)
    |> assign(:page_title, slug)
  end

  defp update_socket_with_article(socket, slug, article) do
    socket
    |> assign(:slug, slug)
    |> assign(:article, article)
    |> assign_content(article)
    |> assign(:page_title, article.title)
  end

  def assign_content(socket, nil), do: assign(socket, :content, nil)
  def assign_content(socket, %Article{content: nil}), do: assign(socket, :content, nil)

  def assign_content(socket, %Article{content: markdown}) do
    case Earmark.as_html(markdown,
           escape: false,
           inner_html: true,
           footnotes: true,
           breaks: true,
           postprocessor: &tailwindify/1
         ) do
      {:ok, html, _deprecation} ->
        assign(socket, :content, html)

      {:error, html, error_message} ->
        socket
        |> assign(:content, html)
        |> put_flash(:error, error_message)
    end
  end

  defp tailwindify(nil), do: nil
  defp tailwindify({tag, attrs, inner, map}), do: {tag, classify(tag, attrs), inner, map}
  defp tailwindify(string_only) when is_binary(string_only), do: string_only

  defp tailwindify(unexpected) do
    Logger.warn("unexpected tailwindify-content: #{inspect(unexpected)}")
  end

  defp classify(tag, attrs, acc \\ [])
  defp classify(tag, [], acc), do: [{"class", "blog-#{tag}"} | acc]

  defp classify(tag, [hd | tl], acc) do
    case hd do
      {"class", current} -> [{"class", current <> " blog-#{tag}"} | tl] ++ acc
      _ -> classify(tag, tl, [hd | acc])
    end
  end
end
