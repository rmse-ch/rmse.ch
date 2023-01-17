defmodule Rmse.Links.LinkCollection do
  use Ecto.Schema
  import Ecto.Changeset
  alias Rmse.Links.Link

  schema "link_collections" do
    field :name_en, :string
    field :name_de, :string

    field :active, :boolean

    field :position, :integer

    has_many :links, Link

    timestamps()
  end

  @doc false
  def changeset(link_collection, attrs) do
    link_collection
    |> cast(attrs, [:name_de, :name_en, :position, :active])
    |> validate_required([:name_de, :name_en, :position, :active])
  end
end
