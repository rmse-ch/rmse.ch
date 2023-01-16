defmodule RmseWeb.PreferencesOnMount do
  import Phoenix.Component
  import Phoenix.LiveView

  def on_mount(:default, params, session, socket) do
    cond do
      params["lang"] -> Gettext.put_locale(RmseWeb.Gettext, params["lang"])
      session["lang"] -> Gettext.put_locale(RmseWeb.Gettext, session["lang"])
      true -> nil # do nothing
    end

    socket =
      cond do
        params["dark_mode"] -> assign(socket, :dark_mode, to_boolean(params["dark_mode"]))
        session["dark_mode"] -> assign(socket, :dark_mode, to_boolean(session["dark_mode"]))
        true -> socket
      end

    socket =
      if params["lang"] || params["dark_mode"] do
        push_event(socket, "preferences", %{
          "dark_mode" => socket.assigns[:dark_mode],
          "language" => Gettext.get_locale(RmseWeb.Gettext)
        })
      else
        socket
      end

    {:cont, assign(socket, :language, Gettext.get_locale(RmseWeb.Gettext))}
  end

  defp to_boolean("false"), do: false
  defp to_boolean("true"), do: true
  defp to_boolean(nil), do: nil
  defp to_boolean(_), do: false
end
