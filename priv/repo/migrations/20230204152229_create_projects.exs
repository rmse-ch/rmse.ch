defmodule Rmse.Repo.Migrations.CreateProjects do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :start_date, :date, null: false
      add :end_date, :date, null: false
      add :company, :string, null: false
      add :project, :string, null: false
      add :description_de_html, :text, null: false
      add :description_en_html, :text, null: false
      add :skills, {:array, :string}, null: false, default: []
      add :skills_hidden, {:array, :string}, null: false, default: []

      timestamps()
    end
  end
end
