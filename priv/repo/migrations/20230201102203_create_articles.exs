defmodule Rmse.Repo.Migrations.CreateArticles do
  use Ecto.Migration

  def change do
    create table(:articles, primary_key: false) do
      add :id, :id, null: false, primary_key: true
      add :title, :string, null: false
      add :slug, :string, null: false
      add :tags, {:array, :string}
      add :description, :text, null: false
      add :content, :text, null: false
      add :published, :boolean, default: false, null: false
      add :dev_to_id, :integer
      add :medium_id, :integer
      add :medium_url, :string
      add :dev_to_url, :string

      timestamps(
        inserted_at: :created_at,
        type: :utc_datetime
      )
    end

    create unique_index(:articles, [:slug])
  end
end
