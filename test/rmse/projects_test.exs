defmodule Rmse.ProjectsTest do
  use Rmse.DataCase

  alias Rmse.Projects

  describe "projects" do
    import Rmse.ProjectsFixtures

    test "list_projects/0 returns all projects" do
      project = project_fixture()
      assert Projects.list_projects() == [project]
    end
  end
end
