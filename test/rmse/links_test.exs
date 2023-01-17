defmodule Rmse.LinksTest do
  use Rmse.DataCase

  alias Rmse.Links

  describe "link_collections" do
    alias Rmse.Links.LinkCollection

    import Rmse.LinksFixtures

    @invalid_attrs %{name_de: nil, name_en: nil, position: nil}

    test "list_link_collections/0 returns all link_collections" do
      link_collection = link_collection_fixture()
      assert Links.list_link_collections() == [link_collection]
    end

    test "get_link_collection!/1 returns the link_collection with given id" do
      link_collection = link_collection_fixture()
      assert Links.get_link_collection!(link_collection.id) == link_collection
    end

    test "create_link_collection/1 with valid data creates a link_collection" do
      valid_attrs = %{name_de: "some name_de", name_en: "some name_en", position: 42}

      assert {:ok, %LinkCollection{} = link_collection} = Links.create_link_collection(valid_attrs)
      assert link_collection.name_de == "some name_de"
      assert link_collection.name_en == "some name_en"
      assert link_collection.position == 42
    end

    test "create_link_collection/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Links.create_link_collection(@invalid_attrs)
    end

    test "update_link_collection/2 with valid data updates the link_collection" do
      link_collection = link_collection_fixture()
      update_attrs = %{name_de: "some updated name_de", name_en: "some updated name_en", position: 43}

      assert {:ok, %LinkCollection{} = link_collection} = Links.update_link_collection(link_collection, update_attrs)
      assert link_collection.name_de == "some updated name_de"
      assert link_collection.name_en == "some updated name_en"
      assert link_collection.position == 43
    end

    test "update_link_collection/2 with invalid data returns error changeset" do
      link_collection = link_collection_fixture()
      assert {:error, %Ecto.Changeset{}} = Links.update_link_collection(link_collection, @invalid_attrs)
      assert link_collection == Links.get_link_collection!(link_collection.id)
    end

    test "delete_link_collection/1 deletes the link_collection" do
      link_collection = link_collection_fixture()
      assert {:ok, %LinkCollection{}} = Links.delete_link_collection(link_collection)
      assert_raise Ecto.NoResultsError, fn -> Links.get_link_collection!(link_collection.id) end
    end

    test "change_link_collection/1 returns a link_collection changeset" do
      link_collection = link_collection_fixture()
      assert %Ecto.Changeset{} = Links.change_link_collection(link_collection)
    end
  end

  describe "links" do
    alias Rmse.Links.Link

    import Rmse.LinksFixtures

    @invalid_attrs %{description_de: nil, description_en: nil, href: nil, name_de: nil, name_en: nil, position: nil}

    test "list_links/0 returns all links" do
      link = link_fixture()
      assert Links.list_links() == [link]
    end

    test "get_link!/1 returns the link with given id" do
      link = link_fixture()
      assert Links.get_link!(link.id) == link
    end

    test "create_link/1 with valid data creates a link" do
      valid_attrs = %{description_de: "some description_de", description_en: "some description_en", href: "some href", name_de: "some name_de", name_en: "some name_en", position: 42}

      assert {:ok, %Link{} = link} = Links.create_link(valid_attrs)
      assert link.description_de == "some description_de"
      assert link.description_en == "some description_en"
      assert link.href == "some href"
      assert link.name_de == "some name_de"
      assert link.name_en == "some name_en"
      assert link.position == 42
    end

    test "create_link/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Links.create_link(@invalid_attrs)
    end

    test "update_link/2 with valid data updates the link" do
      link = link_fixture()
      update_attrs = %{description_de: "some updated description_de", description_en: "some updated description_en", href: "some updated href", name_de: "some updated name_de", name_en: "some updated name_en", position: 43}

      assert {:ok, %Link{} = link} = Links.update_link(link, update_attrs)
      assert link.description_de == "some updated description_de"
      assert link.description_en == "some updated description_en"
      assert link.href == "some updated href"
      assert link.name_de == "some updated name_de"
      assert link.name_en == "some updated name_en"
      assert link.position == 43
    end

    test "update_link/2 with invalid data returns error changeset" do
      link = link_fixture()
      assert {:error, %Ecto.Changeset{}} = Links.update_link(link, @invalid_attrs)
      assert link == Links.get_link!(link.id)
    end

    test "delete_link/1 deletes the link" do
      link = link_fixture()
      assert {:ok, %Link{}} = Links.delete_link(link)
      assert_raise Ecto.NoResultsError, fn -> Links.get_link!(link.id) end
    end

    test "change_link/1 returns a link changeset" do
      link = link_fixture()
      assert %Ecto.Changeset{} = Links.change_link(link)
    end
  end
end
