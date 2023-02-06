defmodule Rmse.BlogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Rmse.Blog` context.
  """

  @doc """
  Generate a unique article slug.
  """
  def unique_article_slug, do: "some-slug#{System.unique_integer([:positive])}"

  @doc """
  Generate a article.
  """
  def article_fixture(attrs \\ %{}) do
    {:ok, article} =
      attrs
      |> Enum.into(%{
        id: System.unique_integer([:positive]),
        title: "some title",
        slug: unique_article_slug(),
        tags: ["tag1", "tag2"],
        summary: "some summarymix",
        content: "some content",
        dev_to_id: 41,
        dev_to_url: "https://dev.to/41",
        medium_id: 42,
        medium_url: "https://medium.com/42",
        published: true,
        created_at: ~U[2023-01-31 10:22:00Z],
        updated_at: ~U[2023-01-31 10:23:00Z]
      })
      |> Rmse.Blog.create_article()

    article
  end
end
