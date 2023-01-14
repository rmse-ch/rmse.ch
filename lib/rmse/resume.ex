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

  @doc """
  Creates a work experience.

  ## Examples

      iex> create_experience(%{company: "ABC", job_title_de: "De", job_title_en: "en", start_year: 2000})
      {:ok, %Experience{}}

      iex> create_aaa(%{start_year: 11})
      {:error, %Ecto.Changeset{}}

  """
  def create_experience(attrs \\ %{}) do
    %Experience{}
    |> Experience.changeset(attrs)
    |> Repo.insert()
  end
end
