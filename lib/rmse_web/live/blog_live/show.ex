defmodule RmseWeb.BlogLive.Show do
  require Logger

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
    article = Blog.get_article_by_slug(slug)

    socket
    |> assign(:slug, slug)
    |> assign(:article, article)
    |> assign_content(article.content)
    |> assign(:page_title, article.title)
  end

  def assign_content(socket, nil), do: socket

  def assign_content(socket, markdown) do
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

  # defp tailwindify({"h1", attrs, inner, map}), do: {"h1", [{"class", "text-3xl font-bold tracking-tight text-zinc-800 dark:text-zinc-100 sm:text-4xl mt-6 mb-6"} | attrs], inner, map}
  # defp tailwindify({"h2", attrs, inner, map}), do: {"h2", [{"class", "text-xl font-semibold tracking-tight text-zinc-800 dark:text-zinc-100 sm:text-2xl mt-4 mb-4"} | attrs], inner, map}

  # defp tailwindify({"ol", attrs, inner, map}), do: {"div", [], [{"ol", [{"class", "list-decimal list-outside"} | attrs], inner, map}], %{}}
  # defp tailwindify({"ul", attrs, inner, map}), do: {"div", [], [{"ul", [{"class", "list-disc list-outside"} | attrs], inner, map}], %{}}
  # defp tailwindify({"img", attrs, inner, map}), do: {"img", [{"class", "object-contain"} | attrs], inner, map}
end
