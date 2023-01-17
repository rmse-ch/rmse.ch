defmodule Rmse.Repo.Migrations.CreateLinks do
  use Ecto.Migration

  def change do
    create table(:links) do
      add :href, :string, null: false
      add :title_de, :string, null: false
      add :title_en, :string, null: false
      add :description_de, :text, null: false
      add :description_en, :text, null: false
      add :position, :integer, null: false
      add :active, :boolean, null: false, default: true

      add :link_collection_id, references(:link_collections, on_delete: :delete_all)

      timestamps()
    end

    create index(:links, [:link_collection_id])
  end
end
