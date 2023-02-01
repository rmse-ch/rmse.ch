defmodule Rmse.Repo.Migrations.CreateArticles do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :title, :string, null: false
      add :slug, :string, null: false
      add :tags, {:array, :string}
      add :description, :text, null: false
      add :content, :text, null: false
      add :published, :boolean, default: false, null: false
      add :dev_to_id, :integer
      add :medium_id, :integer

      timestamps(
        inserted_at: :created_at,
        type: :utc_datetime
      )
    end

    create unique_index(:articles, [:slug])
  end
end
