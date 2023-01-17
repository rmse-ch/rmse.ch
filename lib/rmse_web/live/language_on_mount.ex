defmodule RmseWeb.LanguageOnMount do
  import Phoenix.Component

  def on_mount(:default, params, session, socket) do
    cond do
      params["lang"] ->
        Gettext.put_locale(RmseWeb.Gettext, params["lang"])

      session["current_language"] ->
        Gettext.put_locale(RmseWeb.Gettext, session["current_language"])

      # do nothing
      true ->
        nil
    end

    {:cont, assign(socket, :language, Gettext.get_locale(RmseWeb.Gettext))}
  end
end
