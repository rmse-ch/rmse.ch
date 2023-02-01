defmodule Rmse.Blog do
  @moduledoc """
  The Blog context.
  """

  import Ecto.Query, warn: false
  alias Rmse.Repo

  alias Rmse.Blog.Article

  @doc """
  Returns the paginated list of published articles.

  ## Examples

      iex> list_articles()
      [%Article{}, ...]

  """
  def list_articles(page \\ 0) do
    query =
      from a in Article,
        where: a.published,
        order_by: [desc: a.created_at],
        limit: 20,
        offset: ^page * 20

    Repo.all(query)
  end

  @doc """
  Returns a list of the 3 newest published articles

  ## Examples

      iex> list_newest_articles()
      [%Article{}, ...]

  """
  def list_newest_articles do
    query =
      from a in Article,
        where: a.published,
        order_by: [desc: a.created_at],
        limit: 3

    Repo.all(query)
  end

  @doc """
  Gets a single article.

  Raises `Ecto.NoResultsError` if the Article does not exist.

  ## Examples

      iex> get_article!(123)
      %Article{}

      iex> get_article!(456)
      ** (Ecto.NoResultsError)

  """
  def get_article!(id), do: Repo.get!(Article, id)

  @doc """
  Gets a single article by using the slug.

  Raises `Ecto.NoResultsError` if the Article does not exist.

  ## Examples

      iex> get_article_by_slug("my-short-slug")
      %Article{}

      iex> get_article_by_slug("my-unknown-slug")
      nil

  """
  def get_article_by_slug(slug), do: Repo.get_by(Article, slug: slug)

  @doc """
  Creates a article.

  ## Examples

      iex> create_article(%{field: value})
      {:ok, %Article{}}

      iex> create_article(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_article(attrs \\ %{}) do
    %Article{}
    |> Article.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a article.

  ## Examples

      iex> update_article(article, %{field: new_value})
      {:ok, %Article{}}

      iex> update_article(article, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_article(%Article{} = article, attrs) do
    article
    |> Article.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a article.

  ## Examples

      iex> delete_article(article)
      {:ok, %Article{}}

      iex> delete_article(article)
      {:error, %Ecto.Changeset{}}

  """
  def delete_article(%Article{} = article) do
    Repo.delete(article)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking article changes.

  ## Examples

      iex> change_article(article)
      %Ecto.Changeset{data: %Article{}}

  """
  def change_article(%Article{} = article, attrs \\ %{}) do
    Article.changeset(article, attrs)
  end
end
