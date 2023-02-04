defmodule Rmse.Projects do
  @moduledoc """
  The Projects context.
  """

  import Ecto.Query, warn: false
  alias Rmse.Repo

  alias Rmse.Projects.Project

  @doc """
  Returns the list of projects with optional filter by skills.

  ## Examples

      iex> list_projects()
      [%Project{}, ...]

      iex> list_projects("ddd")
      [%Project{}, ...]

  """
  def list_projects(skill \\ nil) do
    query =
      from p in Project,
        order_by: [desc: p.end_date, desc: p.start_date, desc: p.id]

    query_with_skill_limitation =
      if skill do
        from q in query,
          where: ^skill in q.skills or ^skill in q.skills_hidden
      else
        query
      end

    Repo.all(query_with_skill_limitation)
  end
end
