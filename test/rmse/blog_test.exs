defmodule Rmse.BlogTest do
  use Rmse.DataCase

  alias Rmse.Blog

  describe "articles" do
    alias Rmse.Blog.Article

    import Rmse.BlogFixtures

    @invalid_attrs %{
      content: nil,
      created_at: nil,
      description: nil,
      dev_to_id: nil,
      medium_id: nil,
      published: nil,
      slug: nil,
      tags: nil,
      title: nil,
      updated_at: nil
    }

    test "list_articles/1 returns 1 page of articles" do
      article_published = article_fixture()
      _article_unpublished = article_fixture(%{published: false})
      assert Blog.list_articles(0) == [article_published]
      assert Blog.list_articles(1) == []
    end

    test "list_newest_articles/0 returns list of published articles" do
      article_published = article_fixture()
      _article_unpublished = article_fixture(%{published: false})
      assert Blog.list_newest_articles() == [article_published]
    end

    test "get_article!/1 returns the article with given id" do
      article = article_fixture()
      assert Blog.get_article!(article.id) == article
    end

    test "get_article_by_slug/1 returns the article with given slug" do
      article = article_fixture()
      assert Blog.get_article_by_slug(article.slug) == article
    end

    test "get_article_by_slug/1 without known slug returns nothing" do
      article = article_fixture()
      assert Blog.get_article_by_slug(article.slug <> "-") == nil
    end

    test "create_article/1 with valid data creates a article" do
      valid_attrs = %{
        content: "some content",
        created_at: ~U[2023-01-31 10:22:00Z],
        description: "some description",
        dev_to_id: 42,
        medium_id: 42,
        published: true,
        slug: "some slug",
        tags: ["option1", "option2"],
        title: "some title",
        updated_at: ~U[2023-01-31 10:22:00Z]
      }

      assert {:ok, %Article{} = article} = Blog.create_article(valid_attrs)
      assert article.content == "some content"
      assert article.created_at == ~U[2023-01-31 10:22:00Z]
      assert article.description == "some description"
      assert article.dev_to_id == 42
      assert article.medium_id == 42
      assert article.published == true
      assert article.slug == "some slug"
      assert article.tags == ["option1", "option2"]
      assert article.title == "some title"
      assert article.updated_at == ~U[2023-01-31 10:22:00Z]
    end

    test "create_article/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blog.create_article(@invalid_attrs)
    end

    test "update_article/2 with valid data updates the article" do
      article = article_fixture()

      update_attrs = %{
        content: "some updated content",
        created_at: ~U[2023-02-01 10:22:00Z],
        description: "some updated description",
        dev_to_id: 43,
        medium_id: 43,
        published: false,
        slug: "some updated slug",
        tags: ["option1"],
        title: "some updated title",
        updated_at: ~U[2023-02-01 10:22:00Z]
      }

      assert {:ok, %Article{} = article} = Blog.update_article(article, update_attrs)
      assert article.content == "some updated content"
      assert article.created_at == ~U[2023-02-01 10:22:00Z]
      assert article.description == "some updated description"
      assert article.dev_to_id == 43
      assert article.medium_id == 43
      assert article.published == false
      assert article.slug == "some updated slug"
      assert article.tags == ["option1"]
      assert article.title == "some updated title"
      assert article.updated_at == ~U[2023-02-01 10:22:00Z]
    end

    test "update_article/2 with invalid data returns error changeset" do
      article = article_fixture()
      assert {:error, %Ecto.Changeset{}} = Blog.update_article(article, @invalid_attrs)
      assert article == Blog.get_article!(article.id)
    end

    test "delete_article/1 deletes the article" do
      article = article_fixture()
      assert {:ok, %Article{}} = Blog.delete_article(article)
      assert_raise Ecto.NoResultsError, fn -> Blog.get_article!(article.id) end
    end

    test "change_article/1 returns a article changeset" do
      article = article_fixture()
      assert %Ecto.Changeset{} = Blog.change_article(article)
    end
  end
end
