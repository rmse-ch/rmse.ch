defmodule RmseWeb.Plugs.Locale do
  import Plug.Conn

  @accepted_languages ["de", "fr"]

  def init(default), do: default

  def call(%Plug.Conn{params: %{"lang" => lang}} = conn, _default) do
    conn
    |> put_session(:lang, lang)
    |> set_locale(lang, nil, nil)
  end

  def call(conn, default) do
    set_locale(conn, get_session(conn, :lang), get_req_header(conn, "accept-language"), default)
  end

  defp set_locale(conn, nil, nil, default), do: set_locale_and_conn(conn, default)

  defp set_locale(conn, nil, accept_language, default) do
    case find_best_language(accept_language) do
      nil ->
        set_locale(conn, nil, nil, default)

      lang ->
        set_locale_and_conn(conn, lang)
    end
  end

  defp set_locale(conn, session_value, _req_header, _default),
    do: set_locale_and_conn(conn, session_value)

  defp set_locale_and_conn(conn, locale) do
    Gettext.put_locale(RmseWeb.Gettext, locale)

    put_session(conn, :current_language, locale)
  end

  defp find_best_language(nil), do: nil
  defp find_best_language([]), do: nil

  defp find_best_language([value | _]) do
    value
    |> String.split(",")
    |> Enum.map(&parse_language_option/1)
    |> Enum.sort(&(&1.quality > &2.quality))
    |> Enum.map(& &1.tag)
    |> Enum.reject(&is_nil/1)
    |> ensure_language_fallbacks()
    |> Enum.filter(&Enum.member?(@accepted_languages, &1))
    |> List.first()
  end

  # This is a copy of smeevil / set_locale / headers.ex logic!
  defp parse_language_option(string) do
    captures = Regex.named_captures(~r/^\s?(?<tag>[\w\-]+)(?:;q=(?<quality>[\d\.]+))?$/i, string)

    quality =
      case Float.parse(captures["quality"] || "1.0") do
        {val, _} -> val
        _ -> 1.0
      end

    %{tag: captures["tag"], quality: quality}
  end

  defp ensure_language_fallbacks(tags) do
    Enum.flat_map(tags, fn tag ->
      [language | _] = String.split(tag, "-")
      if Enum.member?(tags, language), do: [tag], else: [tag, language]
    end)
  end
end
