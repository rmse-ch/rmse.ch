defmodule Rmse.Repo.Migrations.CreateLinkCollections do
  use Ecto.Migration

  def change do
    create table(:link_collections) do
      add :name_de, :string, null: false
      add :name_en, :string, null: false
      add :position, :integer, null: false
      add :active, :boolean, null: false, default: true

      timestamps()
    end
  end
end
