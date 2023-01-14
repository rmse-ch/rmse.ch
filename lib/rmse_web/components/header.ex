defmodule RmseWeb.Header do
  use Phoenix.Component

  import RmseWeb.RmseComponents
  alias Phoenix.LiveView.JS

  use RmseWeb, :verified_routes

  attr :rest, :global

  def close_icon(assigns) do
    ~H"""
    <svg viewBox="0 0 24 24" aria-hidden="true" {@rest}>
      <path
        d="m17.25 6.75-10.5 10.5M6.75 6.75l10.5 10.5"
        fill="none"
        stroke="currentColor"
        strokeWidth="1.5"
        strokeLinecap="round"
        strokeLinejoin="round"
      />
    </svg>
    """
  end

  attr :rest, :global

  def sun_icon(assigns) do
    ~H"""
    <svg
      viewBox="0 0 24 24"
      strokeWidth="1.5"
      strokeLinecap="round"
      strokeLinejoin="round"
      aria-hidden="true"
      {@rest}
    >
      <path d="M8 12.25A4.25 4.25 0 0 1 12.25 8v0a4.25 4.25 0 0 1 4.25 4.25v0a4.25 4.25 0 0 1-4.25 4.25v0A4.25 4.25 0 0 1 8 12.25v0Z" />
      <path
        d="M12.25 3v1.5M21.5 12.25H20M18.791 18.791l-1.06-1.06M18.791 5.709l-1.06 1.06M12.25 20v1.5M4.5 12.25H3M6.77 6.77 5.709 5.709M6.77 17.73l-1.061 1.061"
        fill="none"
      />
    </svg>
    """
  end

  attr :rest, :global

  def moon_icon(assigns) do
    ~H"""
    <svg viewBox="0 0 24 24" aria-hidden="true" {@rest}>
      <path
        d="M17.25 16.22a6.937 6.937 0 0 1-9.47-9.47 7.451 7.451 0 1 0 9.47 9.47ZM12.75 7C17 7 17 2.75 17 2.75S17 7 21.25 7C17 7 17 11.25 17 11.25S17 7 12.75 7Z"
        strokeWidth="1.5"
        strokeLinecap="round"
        strokeLinejoin="round"
      />
    </svg>
    """
  end

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
            <.mobile_nav_item href="/about">About</.mobile_nav_item>

            <.mobile_nav_item href="/motorcycle">Motorcycle</.mobile_nav_item>

            <.mobile_nav_item href="/blog">Blog</.mobile_nav_item>

            <.mobile_nav_item href="/projects">Projects</.mobile_nav_item>

            <.mobile_nav_item href="/apps">Apps</.mobile_nav_item>

            <.mobile_nav_item href="/uses">Uses</.mobile_nav_item>
          </ul>
        </nav>
      </div>
    </div>
    """
  end

  attr :href, :string, required: true
  attr :is_active, :boolean, required: false, default: false
  slot :inner_block, doc: "the optional inner block that renders the icon"

  def nav_item(assigns) do
    # TODO: handle the isactive somehow, not yet sure how I can do this here!!
    # let isActive = useRouter().pathname === href
    extended_class =
      if assigns[:is_active],
        do: "text-teal-500 dark:text-teal-400",
        else: "hover:text-teal-500 dark:hover:text-teal-400"

    ~H"""
    <li>
      <.link href={@href} class={"relative block px-3 py-2 transition #{extended_class}"}>
        <%= render_slot(@inner_block) %>
        <%= if @is_active do %>
          <span class="absolute inset-x-1 -bottom-px h-px bg-gradient-to-r from-teal-500/0 via-teal-500/40 to-teal-500/0 dark:from-teal-400/0 dark:via-teal-400/40 dark:to-teal-400/0" />
        <% end %>
      </.link>
    </li>
    """
  end

  attr :rest, :global

  def desktop_navigation(assigns) do
    ~H"""
    <nav {@rest}>
      <ul class="flex rounded-full bg-white/90 px-3 text-sm font-medium text-zinc-800 shadow-lg shadow-zinc-800/5 ring-1 ring-zinc-900/5 backdrop-blur dark:bg-zinc-800/90 dark:text-zinc-200 dark:ring-white/10">
        <.nav_item href="/about">About</.nav_item>

        <.nav_item href="/motorcycle">Motorcycle</.nav_item>

        <.nav_item href="/blog">Blog</.nav_item>

        <.nav_item href="/projects">Projects</.nav_item>
        <.nav_item href="/apps">Apps</.nav_item> 
        <.nav_item href="/uses">Uses</.nav_item>
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
        src={~p"/images/avatar.jpg"}
        alt=""
        sizes={if @large, do: "4rem", else: "2.25rem"}
        class={"rounded-full bg-zinc-100 object-cover dark:bg-zinc-800 #{if @large, do: "h-16 w-16", else: "h-9 w-9"}"}
        priority
      />
    </.link>
    """
  end

  def mode_toggle(assigns) do
    ~H"""
    <button
      type="button"
      aria-label="Toggle dark mode"
      class="group rounded-full bg-white/90 px-3 py-2 shadow-lg shadow-zinc-800/5 ring-1 ring-zinc-900/5 backdrop-blur transition dark:bg-zinc-800/90 dark:ring-white/10 dark:hover:ring-white/20"
      onClick="toggleMode()"
    >
      <.sun_icon class="h-6 w-6 fill-zinc-100 stroke-zinc-500 transition group-hover:fill-zinc-200 group-hover:stroke-zinc-700 dark:hidden [@media(prefers-color-scheme:dark)]:fill-teal-50 [@media(prefers-color-scheme:dark)]:stroke-teal-500 [@media(prefers-color-scheme:dark)]:group-hover:fill-teal-50 [@media(prefers-color-scheme:dark)]:group-hover:stroke-teal-600" />
      <.moon_icon class="hidden h-6 w-6 fill-zinc-700 stroke-zinc-500 transition dark:block [@media(prefers-color-scheme:dark)]:group-hover:stroke-zinc-400 [@media_not_(prefers-color-scheme:dark)]:fill-teal-400/10 [@media_not_(prefers-color-scheme:dark)]:stroke-teal-500" />
    </button>
    """
  end

  # bg-white/90 px-3 text-sm font-medium text-zinc-800 shadow-lg shadow-zinc-800/5 ring-1 ring-zinc-900/5 backdrop-blur dark:bg-zinc-800/90 dark:text-zinc-200 dark:ring-white/10

  def language_toggle(assigns) do
    ~H"""
    <button
      type="button"
      aria-label="Toggle Language"
      class="group rounded-full bg-white/90 px-3 py-2 text-sm font-medium shadow-lg shadow-zinc-800/5 ring-1 ring-zinc-900/5 backdrop-blur transition dark:bg-zinc-800/90 dark:text-zinc-200 dark:ring-white/10 dark:hover:ring-white/20 mr-2"
    >
      <div class="h-6 w-6 fill-zinc-100 stroke-zinc-500 transition group-hover:fill-zinc-200 group-hover:stroke-zinc-700 hover:text-teal-500 dark:hover:text-teal-400">
        de
      </div>
    </button>
    """
  end

  def header(assigns) do
    # useRouter().pathname === "/"
    is_home_page = false

    ~H"""
    <header
      class="pointer-events-none relative z-50 flex flex-col"
      style="height: var(--header-height), marginBottom: var(--header-mb)"
    >
      <div class="top-0 z-10 h-16 pt-6" style="position: var(--header-position)">
        <.container
          class="top-[var(--header-top,theme(spacing.6))] w-full"
          style="position: var(--header-inner-position)"
        >
          <div class="relative flex gap-4">
            <div class="flex flex-1">
              <%= if !is_home_page do %>
                <.avatar_container>
                  <.avatar />
                </.avatar_container>
              <% end %>
            </div>

            <div class="flex flex-1 justify-end md:justify-center">
              <.mobile_navigation class="pointer-events-auto md:hidden" />
              <.desktop_navigation class="pointer-events-auto hidden md:block" />
            </div>

            <div class="flex justify-end md:flex-1">
              <div class="pointer-events-auto">
                <.language_toggle />
              </div>

              <div class="pointer-events-auto">
                <.mode_toggle />
              </div>
            </div>
          </div>
        </.container>
      </div>
    </header>
    """
  end
end
