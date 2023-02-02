defmodule RmseWeb.StrapiWebhook do
  alias Ecto.Changeset
  alias Rmse.Blog
  alias Rmse.Blog.Article
  use Phoenix.Controller, formats: [:json]

  require Logger

  import Plug.Conn

  def strapi(conn, %{"event" => event} = body) do
    do_strapi(conn, event, body)
  end

  defp do_strapi(conn, nil, body) do
    Logger.warn("Received nil event type with body #{inspect(body)}, ignoring it")
    json(conn, %{})
  end

  defp do_strapi(conn, "trigger-test", _body), do: json(conn, %{status: "trigger worked"})

  defp do_strapi(conn, "entry.create", %{"entry" => entry}), do: update_or_create(conn, entry)
  defp do_strapi(conn, "entry.update", %{"entry" => entry}), do: update_or_create(conn, entry)

  defp do_strapi(conn, "entry.delete", %{"entry" => entry}) do
    case entry |> prepare_entry_with_db_data() do
      {_entry, nil} ->
        send_resp(conn, 404, "not-in-db")

      {_entry, article} ->
        article
        |> Blog.unpublish_article!()
        |> Blog.delete_article()

        send_resp(conn, 204, "")
    end
  end

  defp do_strapi(conn, "entry.publish", %{"entry" => entry}) do
    case entry |> prepare_entry_with_db_data() |> create_or_update_article_from_db() do
      {:ok, article} ->
        response = Blog.publish_article!(article) |> json_article()
        json(conn, response)

      {:error, %Changeset{errors: errors}} ->
        conn |> put_status(400) |> json(errors)
    end
  end

  defp do_strapi(conn, "entry.unpublish", %{"entry" => entry}) do
    case entry |> prepare_entry_with_db_data() |> create_or_update_article_from_db() do
      {:ok, article} ->
        response = Blog.unpublish_article!(article) |> json_article()
        json(conn, response)

      {:error, %Changeset{errors: errors}} ->
        conn |> put_status(400) |> json(errors)
    end
  end

  defp do_strapi(conn, unknown_event, body) do
    Logger.warn(
      "Received unknown event type: #{unknown_event} with body #{inspect(body)}, ignoring it"
    )

    json(conn, %{})
  end

  defp update_or_create(conn, entry) do
    case update_or_create_in_db(entry) do
      {:ok, article} -> json(conn, json_article(article))
      {:error, %Changeset{errors: errors}} -> conn |> put_status(400) |> json(errors)
    end
  end

  defp update_or_create_in_db(entry) do
    entry |> prepare_entry_with_db_data() |> create_or_update_article_from_db()
  end

  defp prepare_entry_with_db_data(entry) do
    entry
    |> lowercase_entry_keys()
    |> split_tags()
    |> remap_keys()
    |> load_from_db()
  end

  defp lowercase_entry_keys(entry) do
    entry
    |> Enum.map(fn {key, value} -> {String.downcase(key), value} end)
    |> Enum.into(%{})
  end

  defp split_tags(%{"tags" => tags} = entry), do: %{entry | "tags" => String.split(tags)}
  defp split_tags(entry), do: entry

  defp remap_keys(%{"createdat" => createdat, "updatedat" => updatedat} = entry) do
    entry
    |> Map.put("created_at", createdat)
    |> Map.put("updated_at", updatedat)
  end

  defp load_from_db(%{"id" => id} = entry) do
    {entry, Blog.get_article(id)}
  end

  defp create_or_update_article_from_db({entry, nil}), do: Blog.create_article(entry)
  defp create_or_update_article_from_db({entry, article}), do: Blog.update_article(article, entry)

  defp json_article(nil), do: %{}

  defp json_article(%Article{
         id: id,
         slug: slug,
         title: title,
         published: published,
         created_at: created_at,
         updated_at: updated_at,
         dev_to_url: dev_to_url,
         medium_url: medium_url,
         medium_id: medium_id,
         dev_to_id: dev_to_id
       }) do
    %{
      id: id,
      slug: slug,
      title: title,
      published: published,
      created_at: created_at,
      updated_at: updated_at,
      dev_to_url: dev_to_url,
      dev_to_id: dev_to_id,
      medium_url: medium_url,
      medium_id: medium_id
    }
  end
end
