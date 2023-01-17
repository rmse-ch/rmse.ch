defmodule Rmse.Links do
  @moduledoc """
  The Links context.
  """

  import Ecto.Query, warn: false
  alias Rmse.Repo

  alias Rmse.Links.LinkCollection
  alias Rmse.Links.Link

  @doc """
  Returns the list of link_collections.

  ## Examples

      iex> list_link_collections()
      [%LinkCollection{}, ...]

  """
  def list_link_collections do
    query =
      from c in LinkCollection,
        join: l in Link,
        on: l.link_collection_id == c.id,
        where: c.active,
        where: l.active,
        order_by: [asc: c.position, asc: c.id, asc: l.position, asc: l.id],
        preload: [:links]

    query
    |> Repo.all()
    |> Enum.group_by(fn c -> c.id end)
    |> Enum.map(&take_one/1)
  end

  defp take_one({_id, collection_links}) do
    hd(collection_links)
  end
end
