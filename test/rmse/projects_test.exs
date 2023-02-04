defmodule Rmse.ProjectsTest do
  use Rmse.DataCase

  alias Rmse.Projects

  describe "projects" do
    alias Rmse.Projects.Project

    import Rmse.ProjectsFixtures

    @invalid_attrs %{company: nil, description_html: nil, end_date: nil, project: nil, skills: nil, skills_hidden: nil, start_date: nil}

    test "list_projects/0 returns all projects" do
      project = project_fixture()
      assert Projects.list_projects() == [project]
    end

    test "get_project!/1 returns the project with given id" do
      project = project_fixture()
      assert Projects.get_project!(project.id) == project
    end

    test "create_project/1 with valid data creates a project" do
      valid_attrs = %{company: "some company", description_html: "some description_html", end_date: ~D[2023-02-03], project: "some project", skills: ["option1", "option2"], skills_hidden: ["option1", "option2"], start_date: ~D[2023-02-03]}

      assert {:ok, %Project{} = project} = Projects.create_project(valid_attrs)
      assert project.company == "some company"
      assert project.description_html == "some description_html"
      assert project.end_date == ~D[2023-02-03]
      assert project.project == "some project"
      assert project.skills == ["option1", "option2"]
      assert project.skills_hidden == ["option1", "option2"]
      assert project.start_date == ~D[2023-02-03]
    end

    test "create_project/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Projects.create_project(@invalid_attrs)
    end

    test "update_project/2 with valid data updates the project" do
      project = project_fixture()
      update_attrs = %{company: "some updated company", description_html: "some updated description_html", end_date: ~D[2023-02-04], project: "some updated project", skills: ["option1"], skills_hidden: ["option1"], start_date: ~D[2023-02-04]}

      assert {:ok, %Project{} = project} = Projects.update_project(project, update_attrs)
      assert project.company == "some updated company"
      assert project.description_html == "some updated description_html"
      assert project.end_date == ~D[2023-02-04]
      assert project.project == "some updated project"
      assert project.skills == ["option1"]
      assert project.skills_hidden == ["option1"]
      assert project.start_date == ~D[2023-02-04]
    end

    test "update_project/2 with invalid data returns error changeset" do
      project = project_fixture()
      assert {:error, %Ecto.Changeset{}} = Projects.update_project(project, @invalid_attrs)
      assert project == Projects.get_project!(project.id)
    end

    test "delete_project/1 deletes the project" do
      project = project_fixture()
      assert {:ok, %Project{}} = Projects.delete_project(project)
      assert_raise Ecto.NoResultsError, fn -> Projects.get_project!(project.id) end
    end

    test "change_project/1 returns a project changeset" do
      project = project_fixture()
      assert %Ecto.Changeset{} = Projects.change_project(project)
    end
  end
end
