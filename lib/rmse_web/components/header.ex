defmodule RmseWeb.Header do
  use Phoenix.Component

  import RmseWeb.RmseComponents
  import RmseWeb.Gettext

  alias Phoenix.LiveView.JS
  alias RmseWeb.PreferencesComponent

  use RmseWeb, :verified_routes

  attr :rest, :global

  attr :href, :string, required: true
  slot :inner_block, doc: "the optional inner block that renders the icon"

  def mobile_nav_item(assigns) do
    ~H"""
    <li>
      <.link href={@href} class="block py-2">
        <%= render_slot(@inner_block) %>
      </.link>
    </li>
    """
  end

  def show_menu(js \\ %JS{}) do
    js
    |> JS.show(to: "#mobile-menu")
    |> JS.show(to: "#mobile-overlay")
  end

  def hide_menu(js \\ %JS{}) do
    js
    |> JS.hide(to: "#mobile-menu")
    |> JS.hide(to: "#mobile-overlay")
  end

  attr :class, :string, required: false, default: ""
  attr :rest, :global

  def mobile_navigation(assigns) do
    ~H"""
    <div class={"relative #{@class}"} {@rest}>
      <button
        type="button"
        class="group flex items-center rounded-full bg-white/90 px-4 py-2 text-sm font-medium text-zinc-800 shadow-lg shadow-zinc-800/5 ring-1 ring-zinc-900/5 backdrop-blur dark:bg-zinc-800/90 dark:text-zinc-200 dark:ring-white/10 dark:hover:ring-white/20"
        id="menu-button"
        aria-expanded="true"
        aria-haspopup="true"
        phx-click={show_menu()}
      >
        <span>Menu</span> <Heroicons.chevron_down class="h-4 w-4" />
      </button>

      <div
        class="fixed inset-0 z-50 bg-zinc-800/40 backdrop-blur-sm dark:bg-black/80 opacity-100 hidden "
        aria-hidden="true"
        id="mobile-overlay"
      >
      </div>

      <div
        class="fixed inset-x-4 top-8 z-50 origin-top rounded-3xl bg-white p-8 ring-1 ring-zinc-900/5 dark:bg-zinc-900 dark:ring-zinc-800 hidden"
        role="menu"
        aria-orientation="vertical"
        aria-labelledby="menu-button"
        id="mobile-menu"
        tabindex="-1"
      >
        <div class="flex flex-row-reverse items-center justify-between">
          <button aria-label="Close menu" class="-m-1 p-1" phx-click={hide_menu()}>
            <Heroicons.x_mark class="h-6 w-6 text-zinc-500 dark:text-zinc-400" />
          </button>

          <h2 class="text-sm font-medium text-zinc-600 dark:text-zinc-400">
            Navigation
          </h2>
        </div>

        <nav class="mt-6">
          <ul class="-my-2 divide-y divide-zinc-100 text-base text-zinc-800 dark:divide-zinc-100/5 dark:text-zinc-300">
            <.mobile_nav_item href={~p"/about"}><%= gettext("About") %></.mobile_nav_item>

            <.mobile_nav_item href={~p"/motorcycle"}><%= gettext("Motorcycle") %></.mobile_nav_item>

            <.mobile_nav_item href={~p"/blog"}><%= gettext("Blog") %></.mobile_nav_item>

            <.mobile_nav_item href={~p"/projects"}><%= gettext("Projects") %></.mobile_nav_item>

            <.mobile_nav_item href={~p"/apps"}><%= gettext("Apps") %></.mobile_nav_item>

            <.mobile_nav_item href={~p"/contact"}><%= gettext("Contact") %></.mobile_nav_item>

            <.mobile_nav_item href={~p"/links"}><%= gettext("Links") %></.mobile_nav_item>
          </ul>
        </nav>
      </div>
    </div>
    """
  end

  attr :navigate, :string, required: true
  attr :request_path, :string, required: false, default: ""
  slot :inner_block, doc: "the optional inner block that renders the icon"

  def nav_item(assigns) do
    ~H"""
    <li>
      <.link
        navigate={@navigate}
        class={"relative block px-3 py-2 transition #{mark_active(@navigate, @request_path)}"}
      >
        <%= render_slot(@inner_block) %>
        <%= if is_active(@navigate, @request_path) do %>
          <span class="absolute inset-x-1 -bottom-px h-px bg-gradient-to-r from-teal-500/0 via-teal-500/40 to-teal-500/0 dark:from-teal-400/0 dark:via-teal-400/40 dark:to-teal-400/0" />
        <% end %>
      </.link>
    </li>
    """
  end

  defp is_active(href, path), do: String.starts_with?(path, href)
  defp is_homepage(path), do: path == "/"

  defp mark_active(href, path) do
    if is_active(href, path) do
      "text-teal-500 dark:text-teal-400"
    else
      "hover:text-teal-500 dark:hover:text-teal-400"
    end
  end

  attr :rest, :global
  attr :request_path, :string, required: true

  def desktop_navigation(assigns) do
    ~H"""
    <nav {@rest}>
      <ul class="flex rounded-full bg-white/90 px-3 text-sm font-medium text-zinc-800 shadow-lg shadow-zinc-800/5 ring-1 ring-zinc-900/5 backdrop-blur dark:bg-zinc-800/90 dark:text-zinc-200 dark:ring-white/10">
        <.nav_item navigate={~p"/about"} request_path={@request_path}>
          <%= gettext("About") %>
        </.nav_item>

        <.nav_item navigate={~p"/motorcycle"} request_path={@request_path}>
          <%= gettext("Motorcycle") %>
        </.nav_item>

        <.nav_item navigate={~p"/blog"} request_path={@request_path}>
          <%= gettext("Blog") %>
        </.nav_item>

        <.nav_item navigate={~p"/projects"} request_path={@request_path}>
          <%= gettext("Projects") %>
        </.nav_item>

        <.nav_item navigate={~p"/apps"} request_path={@request_path}>
          <%= gettext("Apps") %>
        </.nav_item>

        <.nav_item navigate={~p"/contact"} request_path={@request_path}>
          <%= gettext("Contact") %>
        </.nav_item>

        <.nav_item navigate={~p"/links"} request_path={@request_path}>
          <%= gettext("Links") %>
        </.nav_item>
      </ul>
    </nav>
    """
  end

  attr :class, :string, required: false, default: ""
  attr :rest, :global

  slot :inner_block

  def avatar_container(assigns) do
    ~H"""
    <div
      class={"#{@class} h-10 w-10 rounded-full bg-white/90 p-0.5 shadow-lg shadow-zinc-800/5 ring-1 ring-zinc-900/5 backdrop-blur dark:bg-zinc-800/90 dark:ring-white/10"}
      {@rest}
    >
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  attr :class, :string, required: false, default: ""
  attr :large, :boolean, required: false, default: false
  attr :rest, :global

  def avatar(assigns) do
    ~H"""
    <.link href={~p"/"} aria-label="Home" class={"#{@class} pointer-events-auto"} {@rest}>
      <img
        src={~p"/images/avatar.png"}
        alt=""
        sizes={if @large, do: "4rem", else: "2.25rem"}
        class={"rounded-full bg-zinc-100 object-cover dark:bg-zinc-800 #{if @large, do: "h-16 w-16", else: "h-9 w-9"}"}
        priority
      />
    </.link>
    """
  end

  attr :request_path, :string, required: true
  attr :language, :string, default: "en"

  def header(assigns) do
    ~H"""
    <header
      class="pointer-events-none relative z-50 flex flex-col"
      style="height: var(--header-height); margin-bottom: var(--header-mb);"
    >
      <%= if is_homepage(@request_path) do %>
        <div
          id="homepage-avatar"
          class="order-last mt-[calc(theme(spacing.16)-theme(spacing.3))]"
          phx-hook="HomepageAvatar"
        />
        <.container class="top-0 order-last -mb-3 pt-3" style="position: var(--header-position);">
          <div
            class="top-[var(--avatar-top,theme(spacing.3))] w-full"
            style="position: var(--header-inner-position);"
          >
            <div class="relative">
              <.avatar_container
                class="absolute left-0 top-3 origin-left transition-opacity"
                style="opacity: var(--avatar-border-opacity, 0); transform: var(--avatar-border-transform);"
              />
              <.avatar
                large
                class="block h-16 w-16 origin-left"
                style="transform: var(--avatar-image-transform);"
              />
            </div>
          </div>
        </.container>
      <% end %>

      <div id="header-menu" class="top-0 z-10 h-16 pt-6" style="position: var(--header-position);">
        <.container
          class="top-[var(--header-top,theme(spacing.6))] w-full"
          style="position: var(--header-inner-position);"
        >
          <div class="relative flex gap-4">
            <div class="flex flex-1">
              <%= if !is_homepage(@request_path) do %>
                <.avatar_container>
                  <.avatar />
                </.avatar_container>
              <% end %>
            </div>

            <div class="flex flex-1 justify-end md:justify-center">
              <.mobile_navigation class="pointer-events-auto md:hidden" />
              <.desktop_navigation
                class="pointer-events-auto hidden md:block"
                request_path={@request_path}
              />
            </div>

            <.live_component
              module={PreferencesComponent}
              language={@language}
              request_path={@request_path}
              id="toggle_preference"
            />
          </div>
        </.container>
      </div>
    </header>

    <%= if is_homepage(@request_path) do %>
      <div style="height: var(--content-offset);" />
    <% end %>
    """
  end
end
