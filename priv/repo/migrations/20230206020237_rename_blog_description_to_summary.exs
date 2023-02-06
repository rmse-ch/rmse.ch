defmodule Rmse.Repo.Migrations.RenameBlogDescriptionToSummary do
  use Ecto.Migration

  def change do
    rename table(:articles), :description, to: :summary
  end
end
