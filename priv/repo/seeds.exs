# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Rmse.Repo.insert!(%Rmse.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Rmse.Repo

# Working Experience
alias Rmse.Resume.Experience

Repo.delete_all(Experience)

Repo.insert!(%Experience{
  company: "R. Metzger Software Engineering GmbH",
  job_title_de: "Freelancer",
  job_title_en: "Freelancer",
  logo_url: "logo_rmse.png",
  start_year: 2015,
  end_year: nil
})

Repo.insert!(%Experience{
  company: "Swisscom IT Services",
  job_title_de: "Banking Consultant",
  job_title_en: "Banking Consultant",
  logo_url: "logo_swisscom.png",
  start_year: 2014,
  end_year: 2015
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
  company: "CompuGroup Medical Schweiz AG",
  job_title_de: "Software Engineer",
  job_title_en: "Software Engineer",
  logo_url: "logo_compugroup.jpg",
  start_year: 2010,
  end_year: 2011
})

Repo.insert!(%Experience{
  company: "ti&m",
  job_title_de: "Senior Software Engineer",
  job_title_en: "Senior Software Engineer",
  logo_url: "logo_ti8m.png",
  start_year: 2009,
  end_year: 2010
})

Repo.insert!(%Experience{
  company: "Assentis Technologies AG",
  job_title_de: "Junior Software Engineer",
  job_title_en: "Junior Software Engineer",
  logo_url: "logo_assentis.png",
  start_year: 2005,
  end_year: 2009
})
