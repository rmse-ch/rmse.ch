defmodule Rmse.ResumeFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Rmse.Resume` context.
  """

  @doc """
  Generate a work experience.
  """
  def experience_fixture(attrs \\ %{}) do
    {:ok, experience} =
      attrs
      |> Enum.into(%{
        company: "some company",
        end_year: 2015,
        job_title_de: "some job_title de",
        job_title_en: "some job_title en",
        logo_url: "some_logo_url.png",
        start_year: 2022
      })
      |> Rmse.Resume.create_experience()

    experience
  end
end
