defmodule RmseWeb.IndexLive do
  use RmseWeb, :live_view

  import RmseWeb.SocialIconsComponent
  import RmseWeb.CardComponent

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:articles, load_blog_articles())
     |> assign(:resume, load_resume())}

    # TODO: load twitter stream (and may be instagram)
  end

  def article(assigns) do
    ~H"""
    <.card>
      <.card_title href={"/articles/#{@article.slug}"}>
        <%= @article.title %>
      </.card_title>
      <.card_eyebrow date-time={@article.date} decorate>
        <%= @article.date %>
      </.card_eyebrow>
      <.card_description><%= @article.description %></.card_description>
      <.card_cta>Read article</.card_cta>
    </.card>
    """
  end

  def resume(assigns) do
    ~H"""
    <div class="rounded-2xl border border-zinc-100 p-6 dark:border-zinc-700/40">
      <h2 class="flex text-sm font-semibold text-zinc-900 dark:text-zinc-100">
        <Heroicons.briefcase class="h-6 w-6 flex-none" />
        <span class="ml-3">Work</span>
      </h2>
      <ol class="mt-6 space-y-4">
      <%= for role <- @resume do %>
          <li class="flex gap-4">
            <div class="relative mt-1 flex h-10 w-10 flex-none items-center justify-center rounded-full shadow-md shadow-zinc-800/5 ring-1 ring-zinc-900/5 dark:border dark:border-zinc-700/50 dark:bg-zinc-800 dark:ring-0">
              <%= if role.logo do %>
                <img src={~p"/images/logos/#{role.logo}"} alt="" class="h-7 w-7" unoptimized />
              <% end %>
            </div>
            <dl class="flex flex-auto flex-wrap gap-x-2">
              <dt class="sr-only">Company</dt>
              <dd class="w-full flex-none text-sm font-medium text-zinc-900 dark:text-zinc-100">
                <%= role.company %>
              </dd>
              <dt class="sr-only">Role</dt>
              <dd class="text-xs text-zinc-500 dark:text-zinc-400">
                <%= role.title %>
              </dd>
              <dt class="sr-only">Date</dt>
              <dd
              class="ml-auto text-xs text-zinc-400 dark:text-zinc-500"
                aria-label={"#{show_label(role.start)} until #{show_label(role.end)}"}
              >
                <time dateTime={date_time(role.start)}>
                  <%= show_label(role.start) %>
                </time>
                <span aria-hidden="true">—</span>
                <time dateTime={date_time(role.end)}>
                  <%= show_label(role.end) %>
                </time>
              </dd>
            </dl>
          </li>
          <% end %>
      </ol>
      <.rmse_button variant={:secondary} class="group mt-6 w-full">
        Download CV
        <.arrow_down class="h-4 w-4 stroke-zinc-400 transition group-active:stroke-zinc-600 dark:group-hover:stroke-zinc-50 dark:group-active:stroke-zinc-50" />
      </.rmse_button>
    </div>
    """
  end

  defp load_blog_articles do
    # TODO: read via API from https://developers.forem.com/api/v1#tag/articles/operation/getArticles, username = titaniumcoder
    # Link general: https://dev.to/titaniumcoder

    [
      # %{
      #   slug: "article-1",
      #   title: "Creating a first article",
      #   description: "Some very big description",
      #   date: ~D[2022-10-13]
      # },
      # %{
      #   slug: "article-2",
      #   title: "The second article",
      #   description: "A very long description for the second demo article.",
      #   date: ~D[2023-01-12]
      # }
    ]
  end

  defp load_resume do
    # TODO: read from database
    [
      %{
        company: "R. Metzger Software Engineering GmbH",
        title: "Freelancer",
        logo: "logo_rmse.png",
        start: "2015",
        end: %{
          label: "Present",
          dateTime: NaiveDateTime.local_now()
        }
      },
      %{
        company: "Swisscom IT Services",
        title: "Banking Consultant",
        logo: "logo_swisscom.png",
        start: "2014",
        end: "2015"
      },
      %{
        company: "PrimeForce Bern GmbH",
        title: "Senior Software Engineer",
        logo: "logo_primeforce.jpg",
        start: "2011",
        end: "2014"
      },
      %{
        company: "CompuGroup Medical Schweiz AG",
        title: "Software Engineer",
        logo: "logo_compugroup.jpg",
        start: "2010",
        end: "2011"
      },
      %{
        company: "ti&m",
        title: "Senior Software Engineer",
        logo: "logo_ti8m.png",
        start: "2009",
        end: "2010"
      },
      %{
        company: "Assentis Technologies AG",
        title: "Junior Software Engineer",
        logo: "logo_assentis.png",
        start: "2005",
        end: "2009"
      }
    ]
  end

  defp show_label(%{label: label}), do: label
  defp show_label(label) when is_binary(label), do: label
  defp show_label(_), do: ""

  defp date_time(%{dateTime: dateTime}), do: dateTime
  defp date_time(dateTime), do: dateTime
end
