defmodule RmseWeb.IndexLive do
  use RmseWeb, :live_view

  import RmseWeb.SocialIconsComponent
  import RmseWeb.CardComponent

  alias Rmse.Blog
  alias Rmse.Resume

  @impl true
  def handle_params(_params, uri, socket) do
    {:noreply, assign_request_path(socket, uri)}
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:articles, load_blog_articles())
     |> assign(:resume, load_resume())}
  end

  def article(assigns) do
    ~H"""
    <.card>
      <.card_title href={"/blog/#{@article.slug}"}>
        <%= @article.title %>
      </.card_title>
      <.card_eyebrow decorate>
        <.format_datetime datetime={@article.created_at} />
      </.card_eyebrow>
      <.card_description><%= @article.summary %></.card_description>
      <.card_cta><%= gettext("Read article") %></.card_cta>
    </.card>
    """
  end

  def resume(assigns) do
    ~H"""
    <div class="rounded-2xl border border-zinc-100 p-6 dark:border-zinc-700/40">
      <h2 class="flex text-sm font-semibold text-zinc-900 dark:text-zinc-100">
        <Heroicons.briefcase class="h-6 w-6 flex-none" />
        <span class="ml-3"><%= gettext("Work") %></span>
      </h2>
      <ol class="mt-6 space-y-4">
        <%= for role <- @resume do %>
          <li class="flex gap-4">
            <div class="relative mt-1 flex h-10 w-10 flex-none items-center justify-center">
              <%= if role.logo_url do %>
                <img src={~p"/images/logos/#{role.logo_url}"} alt="" class="h-10 w-10 object-contain" />
              <% end %>
            </div>
            <dl class="flex flex-auto flex-wrap gap-x-2">
              <dt class="sr-only"><%= gettext("Company") %></dt>
              <dd class="w-full flex-none text-sm font-medium text-zinc-900 dark:text-zinc-100">
                <%= role.company %>
              </dd>
              <dt class="sr-only">Role</dt>
              <dd class="text-xs text-zinc-500 dark:text-zinc-400">
                <%= role.job_title_en %>
                <!-- TODO: job title depending on language! -->
              </dd>
              <dt class="sr-only"><%= gettext("Date") %></dt>
              <dd
                class="ml-auto text-xs text-zinc-400 dark:text-zinc-500"
                aria-label={"#{show_label(role.start_year)} until #{show_label(role.end_year)}"}
              >
                <time>
                  <%= show_label(role.start_year) %>
                </time>
                <span aria-hidden="true">—</span>
                <time>
                  <%= show_label(role.end_year) %>
                </time>
              </dd>
            </dl>
          </li>
        <% end %>
      </ol>
      <.rmse_button variant={:secondary} class="group mt-6 w-full" href={cv_link(@language)}>
        <%= gettext("Download CV") %>
        <.arrow_down class="h-4 w-4 stroke-zinc-400 transition group-active:stroke-zinc-600 dark:group-hover:stroke-zinc-50 dark:group-active:stroke-zinc-50" />
      </.rmse_button>
    </div>
    """
  end

  defp cv_link(language) do
    pdf_name = "cv_rico.metzger_2022_11_#{language}.pdf"
    ~p"/cv/#{pdf_name}"
  end

  defp load_blog_articles do
    Blog.list_newest_articles()
  end

  defp load_resume do
    Resume.list_experiences()
  end

  defp show_label(label) when is_binary(label), do: label
  defp show_label(label) when is_integer(label), do: Integer.to_string(label)
  defp show_label(_), do: gettext("Present")
end
