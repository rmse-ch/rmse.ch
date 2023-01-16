defmodule RmseWeb.SystemDarkModeComponent do
  import Phoenix.Component

  defmacro __using__(_opts \\ []) do
    quote do
      def handle_event("view:dark-mode", %{"systemDarkMode" => systemDarkMode}, socket) do
        case Map.get(socket.assigns, :dark_mode) do
          nil ->
            {:noreply, assign(socket, :dark_mode, systemDarkMode)}

          _ ->
            {:noreply, socket}
        end
      end
    end
  end
end
