defmodule RmseWeb.SystemDarkModeComponent do
  import Phoenix.Component

  defmacro __using__(_opts \\ []) do
    quote do
      def handle_event("view:dark-mode", %{"systemDarkMode" => systemDarkMode}, socket) do
        case Map.get(socket.assigns, :dark_mode) do
          nil ->
            {:noreply,
             socket
             |> push_event("preferences", %{
               "dark_mode" => systemDarkMode
             })
             |> assign(:dark_mode, systemDarkMode)}

          value ->
            {:noreply, socket}
        end
      end
    end
  end
end
