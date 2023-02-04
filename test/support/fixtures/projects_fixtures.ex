defmodule Rmse.ProjectsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Rmse.Projects` context.
  """

  @doc """
  Generate a project.
  """
  def project_fixture(attrs \\ %{}) do
    {:ok, project} =
      attrs
      |> Enum.into(%{
        company: "some company",
        description_html: "some description_html",
        end_date: ~D[2023-02-03],
        project: "some project",
        skills: ["option1", "option2"],
        skills_hidden: ["option1", "option2"],
        start_date: ~D[2023-02-03]
      })
      |> Rmse.Projects.create_project()

    project
  end
end
