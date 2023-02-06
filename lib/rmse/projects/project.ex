defmodule Rmse.Projects.Project do
  use Ecto.Schema

  import Ecto.Changeset

  schema "projects" do
    field :company, :string
    field :description_de_html, :string
    field :description_en_html, :string
    field :end_date, :date
    field :project, :string
    field :skills, {:array, :string}
    field :skills_hidden, {:array, :string}
    field :start_date, :date

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [
      :company,
      :description_de_html,
      :description_en_html,
      :start_date,
      :end_date,
      :project,
      :skills,
      :skills_hidden
    ])
    |> validate_required([
      :company,
      :description_de_html,
      :description_en_html,
      :start_date,
      :end_date,
      :project,
      :skills,
      :skills_hidden
    ])
  end
end
