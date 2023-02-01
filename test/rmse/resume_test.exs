defmodule Rmse.ResumeTest do
  use Rmse.DataCase

  alias Rmse.Resume

  describe "experiences" do
    alias Rmse.Resume.Experience

    test "list_experiences/0 returns all experiences" do
      create_resume()
      [rmse, swisscom, primeforce] = Resume.list_experiences()

      assert rmse.company == "R. Metzger Software Engineering GmbH"
      assert swisscom.company == "Swisscom IT Services"
      assert primeforce.company == "PrimeForce Bern GmbH"
    end
  end

  defp create_resume do
    alias Rmse.Resume.Experience

    Repo.insert!(%Experience{
      company: "R. Metzger Software Engineering GmbH",
      job_title_de: "Freelancer",
      job_title_en: "Freelancer",
      logo_url: "logo_rmse.png",
      start_year: 2015,
      end_year: nil
    })

    Repo.insert!(%Experience{
      company: "PrimeForce Bern GmbH",
      job_title_de: "Senior Software Engineer",
      job_title_en: "Senior Software Engineer",
      logo_url: "logo_primeforce.jpg",
      start_year: 2011,
      end_year: 2014
    })

    Repo.insert!(%Experience{
      company: "Swisscom IT Services",
      job_title_de: "Banking Consultant",
      job_title_en: "Banking Consultant",
      logo_url: "logo_swisscom.png",
      start_year: 2014,
      end_year: 2015
    })
  end
end
