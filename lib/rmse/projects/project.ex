defmodule Rmse.Projects.Project do
  use Ecto.Schema

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
end
