defmodule RmseWeb.Footer do
  use Phoenix.Component

  import RmseWeb.RmseComponents
  import RmseWeb.Gettext

  use RmseWeb, :verified_routes

  attr :class, :string, required: false, default: ""
  attr :href, :string, required: true
  slot :inner_block

  def nav_link(assigns) do
    ~H"""
    <.link href={@href} class={"transition hover:text-teal-500 dark:hover:text-teal-400 #{@class}"}>
      <%= render_slot(@inner_block) %>
    </.link>
    """
  end

  def footer(assigns) do
    ~H"""
    <footer class="mt-32">
      <%= Gettext.get_locale(RmseWeb.Gettext) %>
      <.outer_container>
        <div class="border-t border-zinc-100 pt-10 pb-16 dark:border-zinc-700/40">
          <.inner_container>
            <div class="flex flex-col items-center justify-between gap-6 lg:flex-row">
              <div class="flex flex-wrap gap-6 text-sm font-medium text-zinc-800 dark:text-zinc-200">
                <.nav_link href={~p"/about"}><%= gettext("About") %></.nav_link>
                <.nav_link href={~p"/motorcycle"}><%= gettext("Motorcycle") %></.nav_link>
                <.nav_link href={~p"/blog"}><%= gettext("Blog") %></.nav_link>
                <.nav_link href={~p"/projects"}><%= gettext("Projects") %></.nav_link>
                <.nav_link href={~p"/apps"}><%= gettext("Apps") %></.nav_link>
                <.nav_link href={~p"/contact"}><%= gettext("Contact") %></.nav_link>
                <.nav_link href={~p"/links"}><%= gettext("Links") %></.nav_link>
                <.nav_link href={~p"/conditions"} class="pl-9"><%= gettext("Conditions") %></.nav_link>
                <.nav_link href={~p"/cookies"}><%= gettext("Cookies") %></.nav_link>
              </div>

              <p class="text-sm text-zinc-400 dark:text-zinc-500">
                &copy; <%= Date.utc_today().year %> Rico Metzger
              </p>
            </div>
          </.inner_container>
        </div>
      </.outer_container>
    </footer>
    """
  end
end
