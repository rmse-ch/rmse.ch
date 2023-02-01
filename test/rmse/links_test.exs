defmodule Rmse.LinksTest do
  use Rmse.DataCase

  alias Rmse.Links.LinkCollection
  alias Rmse.Links

  describe "link_collections" do
    alias Rmse.Links.Link

    test "list_link_collections/0 returns the links grouped by collection" do
      # create 3 links, add it to 2 collections and verify that this works
      {link_collection1, link_collection2, inactive_link_collection} = create_link_collections()

      create_link(1, 0, true, link_collection1)
      create_link(2, 1, true, link_collection1)
      create_link(3, 2, false, link_collection1)
      create_link(4, 0, true, link_collection2)
      create_link(5, 0, true, inactive_link_collection)

      [lc1, lc2] = Links.list_link_collections()

      assert lc1.name_en == "link collection 2"
      assert lc2.name_en == "link collection 1"

      assert Enum.count(lc1.links) == 1
      assert Enum.count(lc2.links) == 2

      all_links = Enum.flat_map([lc1, lc2], fn c -> c.links end)

      assert !Enum.any?(all_links, fn e -> e.title_en == "Link 3" end)
      assert !Enum.any?(all_links, fn e -> e.title_en == "Link 5" end)
    end
  end

  defp create_link_collections do
    alias Rmse.Links.LinkCollection

    link_collection1 =
      %LinkCollection{
        name_en: "link collection 1",
        name_de: "Linksammlung 1",
        active: true,
        position: 1
      }
      |> Repo.insert!()

    link_collection2 =
      %LinkCollection{
        name_en: "link collection 2",
        name_de: "Linksammlung 2",
        active: true,
        position: 0
      }
      |> Repo.insert!()

    inactive_link_collection =
      %LinkCollection{
        name_en: "inactive link collection",
        name_de: "Inaktive Linksammlung",
        active: false,
        position: 2
      }
      |> Repo.insert!()

    {link_collection1, link_collection2, inactive_link_collection}
  end

  defp create_link(no, position, active, link_collection) do
    alias Rmse.Links.Link

    %Link{
      title_en: "Link #{no}",
      title_de: "Link #{no}",
      href: "https://l#{no}",
      description_de: "Beschreibung #{no}",
      description_en: "Description #{no}",
      position: position,
      active: active,
      link_collection: link_collection
    }
    |> Repo.insert!()
  end
end
