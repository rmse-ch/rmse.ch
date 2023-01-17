defmodule Rmse.Resume do
  @moduledoc """
  The Resume context.
  """

  import Ecto.Query, warn: false
  alias Rmse.Repo

  alias Rmse.Resume.Experience

  @doc """
  Returns the list of work experiences.

  ## Examples

      iex> list_experiences()
      [%Experience{}, ...]

  """
  def list_experiences do
    query =
      from e in Experience,
        select: e,
        order_by: [desc_nulls_first: e.end_year, desc: e.start_year]

    Repo.all(query)
  end
end
