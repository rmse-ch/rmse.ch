defmodule Rmse.Links.Link do
  alias Rmse.Links.LinkCollection
  use Ecto.Schema
  import Ecto.Changeset

  schema "links" do
    field :title_de, :string
    field :title_en, :string
    field :position, :integer
    field :href, :string
    field :description_de, :string
    field :description_en, :string

    field :active, :boolean

    belongs_to :link_collection, LinkCollection

    timestamps()
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [
      :href,
      :title_de,
      :title_en,
      :description_de,
      :description_en,
      :position,
      :link_collection_id,
      :active
    ])
    |> validate_required([
      :href,
      :title_de,
      :title_en,
      :description_de,
      :description_en,
      :position,
      :active
    ])
    |> cast_assoc(:link_collection)
  end
end
