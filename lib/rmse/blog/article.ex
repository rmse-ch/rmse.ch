defmodule Rmse.Blog.Article do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :id, autogenerate: false}
  schema "articles" do
    field :content, :string
    field :summary, :string
    field :dev_to_id, :integer
    field :dev_to_url, :string
    field :medium_id, :integer
    field :medium_url, :string
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
      :id,
      :title,
      :content,
      :tags,
      :slug,
      :summary,
      :published,
      :dev_to_id,
      :dev_to_url,
      :medium_id,
      :medium_url,
      :created_at,
      :updated_at
    ])
    |> validate_required([
      :id,
      :title,
      :content,
      :tags,
      :slug,
      :summary,
      :published,
      :created_at,
      :updated_at
    ])
    |> unique_constraint(:slug)
  end
end
