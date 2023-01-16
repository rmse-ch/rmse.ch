defmodule RmseWeb.PreferencesComponent do
  use RmseWeb, :live_component

  def render(assigns) do
    ~H"""
    <div class="flex justify-end md:flex-1">
      <div class="pointer-events-auto">
        <button
          type="button"
          aria-label="Toggle Language"
          class="group rounded-full bg-white/90 px-3 py-2 text-sm font-medium shadow-lg shadow-zinc-800/5 ring-1 ring-zinc-900/5 backdrop-blur transition dark:bg-zinc-800/90 dark:text-zinc-200 dark:ring-white/10 dark:hover:ring-white/20 mr-2"
          phx-click="switch_language"
          phx-target={@myself}
          phx-value-path={@request_path}
          phx-value-language={@language}
          phx-disable-with={other_locale(@language)}
        >
          <div class="h-6 w-6 fill-zinc-100 stroke-zinc-500 transition group-hover:fill-zinc-200 group-hover:stroke-zinc-700 hover:text-teal-500 dark:hover:text-teal-400">
            <%= other_locale(@language) %>
          </div>
        </button>
      </div>
      <div class="pointer-events-auto">
        <button
          id="mode_toggle_button"
          type="button"
          aria-label="Toggle dark mode"
          class="group rounded-full bg-white/90 px-3 py-2 shadow-lg shadow-zinc-800/5 ring-1 ring-zinc-900/5 backdrop-blur transition dark:bg-zinc-800/90 dark:ring-white/10 dark:hover:ring-white/20"
          phx-click="switch_dark_mode"
          phx-target={@myself}
          phx-value-path={@request_path}
          phx-value-dark_mode={to_string(@dark_mode)}
        >
          <.sun_icon class="h-6 w-6 fill-zinc-100 stroke-zinc-500 transition group-hover:fill-zinc-200 group-hover:stroke-zinc-700 dark:hidden [@media(prefers-color-scheme:dark)]:fill-teal-50 [@media(prefers-color-scheme:dark)]:stroke-teal-500 [@media(prefers-color-scheme:dark)]:group-hover:fill-teal-50 [@media(prefers-color-scheme:dark)]:group-hover:stroke-teal-600" />
          <.moon_icon class="hidden h-6 w-6 fill-zinc-700 stroke-zinc-500 transition dark:block [@media(prefers-color-scheme:dark)]:group-hover:stroke-zinc-400 [@media_not_(prefers-color-scheme:dark)]:fill-teal-400/10 [@media_not_(prefers-color-scheme:dark)]:stroke-teal-500" />
        </button>
      </div>
    </div>
    """
  end

  def handle_event("switch_language", %{"path" => path, "language" => language}, socket) do
    new_language = other_locale(language)

    uri =
      URI.new!(path)
      |> URI.append_query("lang=#{new_language}")

    {:noreply, push_navigate(socket, to: URI.to_string(uri), replace: true)}
  end

  def handle_event("switch_dark_mode", %{"path" => path, "dark_mode" => dark_mode}, socket) do
    new_dark_mode = invert_boolean(dark_mode)

    uri =
      URI.new!(path)
      |> URI.append_query("dark_mode=#{new_dark_mode}")

      {:noreply, push_navigate(socket, to: URI.to_string(uri), replace: true)}
  end

  defp other_locale("en"), do: "de"
  defp other_locale("de"), do: "en"
  defp other_locale(_), do: "en"

  defp invert_boolean("false"), do: true
  defp invert_boolean("true"), do: false
  defp invert_boolean(_), do: true
end
