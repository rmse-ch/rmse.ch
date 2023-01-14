defmodule RmseWeb.Footer do
  use Phoenix.Component

  import RmseWeb.RmseComponents

  use RmseWeb, :verified_routes

  attr :href, :string, required: true
  slot :inner_block

  def nav_link(assigns) do
    ~H"""
    <.link href={@href} class="transition hover:text-teal-500 dark:hover:text-teal-400">
      <%= render_slot(@inner_block) %>
    </.link>
    """
  end

  def footer(assigns) do
    ~H"""
    <footer class="mt-32">
      <.outer_container>
        <div class="border-t border-zinc-100 pt-10 pb-16 dark:border-zinc-700/40">
          <.inner_container>
            <div class="flex flex-col items-center justify-between gap-6 sm:flex-row">
              <div class="flex gap-6 text-sm font-medium text-zinc-800 dark:text-zinc-200">
                <.nav_link href={~p"/about"}>About</.nav_link>
                <.nav_link href={~p"/motorcycle"}>Motorcycle</.nav_link>
                <.nav_link href={~p"/blog"}>Blog</.nav_link>
                <.nav_link href={~p"/projects"}>Projects</.nav_link>
                <.nav_link href={~p"/apps"}>Apps</.nav_link>
                <.nav_link href={~p"/uses"}>Uses</.nav_link>
              </div>

              <p class="text-sm text-zinc-400 dark:text-zinc-500">
                &copy; <%= Date.utc_today().year %> Rico Metzger. All rights reserved.
              </p>
            </div>
          </.inner_container>
        </div>
      </.outer_container>
    </footer>
    """
  end
end
