defmodule Rmse.Repo.Migrations.AddUrlsToArticles do
  use Ecto.Migration

  def change do
    alter table(:articles) do
      add :medium_url, :string
      add :dev_to_url, :string
    end
  end
end
