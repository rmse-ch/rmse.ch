defmodule Rmse.Repo.Migrations.CreateExperiences do
  use Ecto.Migration

  def change do
    create table(:experiences) do
      add :company, :string, size: 100, null: false
      add :job_title_de, :string, size: 100, null: false
      add :job_title_en, :string, size: 100, null: false
      add :start_year, :integer, min: 1900, null: false
      add :end_year, :integer, min: 1900, null: true
      add :logo_url, :string, null: false

      timestamps()
    end
  end
end
