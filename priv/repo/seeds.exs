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

# insert the default link collection
alias Rmse.Links.LinkCollection
alias Rmse.Links.Link

Repo.delete_all(Link)
Repo.delete_all(LinkCollection)

%LinkCollection{id: lc1} =
  Repo.insert!(%LinkCollection{
    name_de: "Programmiersprachen",
    name_en: "Programming Languages",
    position: 0
  })

Repo.insert!(%Link{
  link_collection_id: lc1,
  title_de: "Scala",
  title_en: "Scala",
  position: 2,
  href: "https://www.scala-lang.org/",
  description_de: """
  Funktionale Programmierung auf der JVM, deutlich verbesserte Standard-Library gegenüber Java. Mein JVM-Favorit.
  """,
  description_en: """
  My favourite programming language on the JVM with better standard library than Java and most important: functional programming.
  """
})

Repo.insert!(%Link{
  link_collection_id: lc1,
  title_de: "Elixir",
  title_en: "Elixir",
  position: 1,
  href: "https://elixir-lang.org/",
  description_de: """
  Im Moment meine Programmiersprache Nummer 1 (wenn ich sie nutzen kann). Sie bringt die Stabilität und das Aktorenmodell der Erlang BEAM VM zusammen mit einer modernen,
  einfach verständlichen funktionalen Programmierung. Und dank dem Ökosystem bietet sie einige grossartige Anbindungen wie das Phoenixframework oder Rustler. All das dann
   auch noch kombiniert mit einer grossartigen Community.
  """,
  description_en: """
  My favourite at the time being. The stability and concurrency of the BEAM combined with a modern, easy to handle functional programming language.
  And for hardware near or system near programming, I can use Rustler with Rust. And all this combined with one of the best communities I know.
  """
})

Repo.insert!(%Link{
  link_collection_id: lc1,
  title_de: "Rust",
  title_en: "Rust",
  position: 2,
  href: "https://www.rust-lang.org/",
  description_de: """
  Systemnahe Programmierung auf einem komplett neuen Level. Hat man sich erst einmal an die Fehlermeldungen beim Kompilieren gewöhnt, ist es eine sehr angenehm zu verwendende Programmiersprache
  """,
  description_en: """
  System near programming at a new level. Once adapted to the compile time error messages, it's a really fun to use language.
  """
})

Repo.insert!(%Link{
  link_collection_id: lc1,
  title_de: "Python",
  title_en: "Python",
  position: 3,
  href: "https://www.scala-lang.org/",
  description_de: """
  Eine der am einfachsten zu lernenden Programmiersprachen und aus dem ML/AI Bereich nicht wegzudenken.
  """,
  description_en: """
  Easy to learn programming language which is used a lot in the field of ML and AI.
  """
})

Repo.insert!(%Link{
  link_collection_id: lc1,
  title_de: "Go",
  title_en: "Go",
  position: 4,
  href: "https://go.dev/",
  description_de: """
  Ebenfalls einfach zu lernende Programmiersprache, hochperformant mit sehr gutem Support für Nebenläufigkeit und einer sehr guten Standard-Library.
  """,
  description_en: """
  Easy to learn, robust, built-in concurrency, a good ecosystem and a great community - a well thought programming language supported by Google.
  """
})

Repo.insert!(%Link{
  link_collection_id: lc1,
  title_de: "Kotlin",
  title_en: "Kotlin",
  position: 5,
  href: "https://kotlinlang.org/",
  description_de: """
  Moderne Java-Programmierung, ein (deutlich) besseres Java.
  """,
  description_en: """
  How Java should be (in my opinion).
  """
})

Repo.insert!(%Link{
  id: lc1,
  title_de: "Java",
  title_en: "Java",
  position: 6,
  href: "https://dev.java/",
  description_de: """
  20 Jahre alte Programmiersprache, die die Welt der Programmierung eroberte und sehr lange dominierte. Nicht mehr wegzudenken.
  """,
  description_en: """
  20 years old, has changed the programming world and dominated it for a very long time.
  """
})

%LinkCollection{id: lc2} =
  Repo.insert!(%LinkCollection{
    name_de: "Produktivität / Freelancer",
    name_en: "Productivity / Freelancing",
    position: 1
  })

Repo.insert!(%Link{
  link_collection_id: lc2,
  title_de: "Toggl",
  title_en: "Toggl",
  position: 0,
  href: "https://toggl.com",
  description_de: """
  Als Freiberufler ist es wichtig, dass ich meine Zeit im Blick behalte, sonst werde ich nicht bezahlt. Ich habe eine Vielzahl von Zeiterfassungsprogrammen ausprobiert, aber am Ende bin ich immer wieder zu Toggl zurückgekehrt.
  """,
  description_en: """
  As a freelancer, keeping track of my time is important or I don't get payed. I tried a multitude of time trackers but at the end always back at toggl.
  """
})

Repo.insert!(%Link{
  link_collection_id: lc2,
  title_de: "Todoist",
  title_en: "Todoist",
  position: 1,
  href: "https://toggl.com",
  description_de: """
  Als Fan von Gettings-Things-Done mag ich diese einfach zu bedienende TODO-App, die ich auf allen meinen Geräten installiert habe.
  """,
  description_en: """
  As a fan of Gettings-Things-Done, I love this simple to use TODO app, which I have installed on all of my devices.
  """
})

Repo.insert!(%Link{
  link_collection_id: lc2,
  title_de: "Trello",
  title_en: "Trello",
  position: 2,
  href: "https://trello.com",
  description_de: """
  Ich bin ehrlich gesagt kein großer Jira-Fan. Trello hingegen ist wirklich gut für die Arbeit in kleinen Teams oder auch für kleinere private Projekte.
  """,
  description_en: """
  I am honestly not a big Jira fan. Trello on the other hand is really good to work in small teams or even on smaller private projects.
  """
})

Repo.insert!(%Link{
  link_collection_id: lc2,
  title_de: "DEV.to",
  title_en: "DEV.to",
  position: 3,
  href: "https://dev.to",
  description_de: """
  Mein Lieblingsblog als Software-Entwickler, und er ist kostenlos.
  """,
  description_en: """
  My favourite blog for developers and it's free.
  """
})

Repo.insert!(%Link{
  link_collection_id: lc2,
  title_de: "Medium",
  title_en: "Medium",
  position: 4,
  href: "https://medium.com",
  description_de: """
  Ein weiterer sehr guter Blog für Entwickler, leider nicht kostenlos.
  """,
  description_en: """
  Another really good blog for developers, unfortunately not free.
  """
})

%LinkCollection{id: lc3} =
  Repo.insert!(%LinkCollection{
    name_de: "Entwicklungswerkzeuge",
    name_en: "Development Tools",
    position: 2
  })

Repo.insert!(%Link{
  link_collection_id: lc3,
  title_de: "Visual Studio Code",
  title_en: "Visual Studio Code",
  position: 0,
  href: "https://code.visualstudio.com",
  description_de: """
  Meine Entwicklungsumgebung für den größten Teil der Entwicklung, die ich heutzutage mache.
  """,
  description_en: """
  My development environment for most of the development I do nowadays.
  """
})

Repo.insert!(%Link{
  link_collection_id: lc3,
  title_de: "JetBrains IntelliJ Ultimate",
  title_en: "JetBrains IntelliJ Ultimate",
  position: 1,
  href: "https://www.jetbrains.com/de-de/idea/",
  description_de: """
  Meiner Meinung nach immer noch die beste IDE für Kotlin und Java. Für nicht-funktionales Scala benutze ich sie auch, während ich für funktionalies Scala ich meist zu Visual Studio Code wechsle.
  """,
  description_en: """
  Still in my opinion the best IDE for Kotlin and Java. I also use it for non functional Scala, while for I mostly switch to Visual Studio Code for functional Scala.
  """
})

Repo.insert!(%Link{
  link_collection_id: lc3,
  title_de: "Figma",
  title_en: "Figma",
  position: 2,
  href: "https://www.figma.com/",
  description_de: """
  Ein einfaches (nicht einfaches) Werkzeug für den Anfang. Ich weiß gar nicht mehr, was ich vorher benutzt habe.
  """,
  description_en: """
  Simple (not easy) to use tool to get you started. I don't even remember what I used before.
  """
})

%LinkCollection{id: lc4} =
  Repo.insert!(%LinkCollection{
    name_de: "Hardware",
    name_en: "Hardware",
    position: 3
  })

Repo.insert!(%Link{
  link_collection_id: lc4,
  title_de: "Apple MacBook Pro",
  title_en: "Apple MacBook Pro",
  position: 0,
  href: "https://www.apple.com/chde/macbook-pro-13/",
  description_de: """
  Ich begann mit Windows mit all seinen Schmerzen, aber seit ich das MacBook Pro für die Entwicklung verwende, fühle ich mich einfach wohl.
  Als nächstes steht der Wechsel zu M2 an (oder ich gebe Linux eine Chance, nachdem ich gute Dinge über NixOS gehört habe).
  """,
  description_en: """
  I started on Windows with all its pains but since using the MacBook Pro for development, I feel just comfortable.
  Now whenever I can I will switch to M2 (or try Linux, hearing good things about NixOS).
  """
})

%LinkCollection{id: lc100} =
  Repo.insert!(%LinkCollection{
    name_de: "Sonstiges",
    name_en: "Misc",
    position: 99
  })

Repo.insert!(%Link{
  link_collection_id: lc100,
  title_de: "Bexio",
  title_en: "Bexio",
  position: 0,
  href: "https://bexio.com",
  description_de: """
  Schweizer Software für Bestellungen, Rechnungen und alles andere, was damit zusammenhängt. Es hat auch eine sehr gute API, die es mir ermöglicht, eine Vielzahl von Dingen zu tun.
  """,
  description_en: """
  Swiss Software for orders, invoices and all other related stuff. It also has a very good API which allows me to do a multitude of things.
  """
})
