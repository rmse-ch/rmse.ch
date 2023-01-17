defmodule Rmse.LinksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Rmse.Links` context.
  """

  @doc """
  Generate a link_collection.
  """
  def link_collection_fixture(attrs \\ %{}) do
    {:ok, link_collection} =
      attrs
      |> Enum.into(%{
        name_de: "some name_de",
        name_en: "some name_en",
        position: 42
      })
      |> Rmse.Links.create_link_collection()

    link_collection
  end

  @doc """
  Generate a link.
  """
  def link_fixture(attrs \\ %{}) do
    {:ok, link} =
      attrs
      |> Enum.into(%{
        description_de: "some description_de",
        description_en: "some description_en",
        href: "some href",
        name_de: "some name_de",
        name_en: "some name_en",
        position: 42
      })
      |> Rmse.Links.create_link()

    link
  end
end
