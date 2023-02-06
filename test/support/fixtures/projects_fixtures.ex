defmodule Rmse.ProjectsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Rmse.Projects` context.
  """

  @doc """
  Generate a project.
  """
  alias Rmse.Repo
  alias Rmse.Projects.Project

  def project_fixture(attrs \\ %{}) do
    attrs =
      attrs
      |> Enum.into(%{
        company: "some company",
        description_de_html: "some description_de_html",
        description_en_html: "some description_en_html",
        end_date: ~D[2023-02-03],
        project: "some project",
        skills: ["skill1", "skill2"],
        skills_hidden: ["skill_hidden1", "skill_hidden2"],
        start_date: ~D[2023-02-03]
      })

    {:ok, project} = Project.changeset(%Project{}, attrs) |> Repo.insert()

    project
  end
end
