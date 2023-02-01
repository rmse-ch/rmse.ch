defmodule Rmse.Blog.Article do
  use Ecto.Schema
  import Ecto.Changeset

  schema "articles" do
    field :content, :string
    field :description, :string
    field :dev_to_id, :integer
    field :medium_id, :integer
    field :published, :boolean, default: false
    field :slug, :string
    field :tags, {:array, :string}
    field :title, :string

    timestamps(
      inserted_at: :created_at,
      inserted_at_source: :created_at,
      type: :utc_datetime
    )
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [
      :title,
      :content,
      :tags,
      :slug,
      :description,
      :published,
      :dev_to_id,
      :medium_id,
      :created_at,
      :updated_at
    ])
    |> validate_required([
      :title,
      :content,
      :tags,
      :slug,
      :description,
      :published,
      :created_at,
      :updated_at
    ])
    |> unique_constraint(:slug)
  end
end
