defmodule Rmse.ResumeTest do
  use Rmse.DataCase

  alias Rmse.Resume

  describe "experiences" do
    alias Rmse.Resume.Experience

    import Rmse.ResumeFixtures

    @invalid_attrs %{company: nil, end_year: nil, job_title_de: nil, job_title_en: nil, logo_url: nil, start_year: nil, end_year: 15}

    test "list_experiences/0 returns all experiences" do
      experience = experience_fixture()
      assert Resume.list_experiences() == [experience]
    end

    test "create_experience/1 with valid data creates a experience" do
      valid_attrs = %{company: "some company", end_year: 2015, job_title_de: "some job_title de", job_title_en: "some job_title en", logo_url: "some logo_url", start_year: 2010}

      assert {:ok, %Experience{} = experience} = Resume.create_experience(valid_attrs)
      assert experience.company == "some company"
      assert experience.end_year == 2015
      assert experience.job_title_de == "some job_title de"
      assert experience.job_title_en == "some job_title en"
      assert experience.logo_url == "some logo_url"
      assert experience.start_year == 2010
    end

    test "create_experience/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Resume.create_experience(@invalid_attrs)
    end
  end
end
