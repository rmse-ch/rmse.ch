defmodule Rmse.Resume.Experience do
  use Ecto.Schema
  import Ecto.Changeset

  schema "experiences" do
    field :company, :string
    field :end_year, :integer
    field :job_title_de, :string
    field :job_title_en, :string
    field :logo_url, :string
    field :start_year, :integer

    timestamps()
  end

  @doc false
  def changeset(work_experience, attrs) do
    work_experience
    |> cast(attrs, [:company, :job_title_de, :job_title_en, :start_year, :end_year, :logo_url])
    |> validate_required([:company, :job_title_de, :job_title_en, :start_year, :logo_url])
    |> validate_number(:start_year, greater_than_or_equal_to: 1900)
    |> validate_number(:end_year, greater_than_or_equal_to: 1900)
    |> validate_length(:company, max: 100)
    |> validate_length(:job_title_de, max: 100)
    |> validate_length(:job_title_en, max: 100)
  end
end
