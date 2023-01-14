defmodule RmseWeb.PageController do
  use RmseWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def about(conn, _params) do
    render(conn, :about, page_title: "About - Rico Metzger")
  end

  def motorcycle(conn, _params) do
    render(conn, :motorcycle, page_title: "Motorcyclist - Rico Metzger")
  end

  def links(conn, _params) do
    # TODO: move this to a live view with database for more comfort
    tool_sections = [
      %{
        title: "Hardware",
        items: [
          %{
            title: "Apple MacBook Pro",
            href: "https://www.apple.com/chde/macbook-pro-13/",
            description:
              """
              I tried hard with Windows but since using the MacBook Pro for development, I could never find myself comfortable anymore.
              It's just more comfortable, feels more easy to work with and the tooling is great. Now whenever I can I will switch to M2
              """
          }
        ]
      },
      %{
        title: "Development Tools",
        items: [
          %{
            title: "Visual Studio Code",
            href: "https://code.visualstudio.com/",
            description:
              "My development environment for most of the development I do nowadays. The only thing that I do on IntelliJ is Java, Kotlin and sometimes Scala."
          },
          %{
            title: "JetBrains IntelliJ Ultimate",
            href: "https://www.jetbrains.com/de-de/idea/",
            description:
              "Still in my opinion the best IDE for Kotlin and Java. Although my personal experience is a little bit shaken in the last 6 month, due to some bad experience. But I had this with every IDE at some point."
          }
        ]
      },
      %{
        title: "Programming Languages",
        items: [
          %{
            title: "Elixir",
            href: "https://elixir-lang.org/",
            description:
              "My absolute favourite at the time being. The stability and concurrency of the BEAM combined with a modern, easy to handle functional programming language. And for hardware near or system near programming, I can use Rustler with Rust."
          },
          %{
            title: "Rust",
            href: "https://www.rust-lang.org/",
            description:
              "System near programming at a new level. Once adapted to the error messages it's a really fun to use language."
          },
          %{
            title: "Scala",
            href: "https://www.scala-lang.org/",
            description:
              "My favourite programming language on the JVM. Then again I honestly never tried Clojure, so I will not say it's the best -- it just feels good for me."
          },
          %{
            title: "Python",
            href: "https://python.org",
            description:
              "A really good programming language for getting things done quickly. Naturally also used widely in the data world."
          },
          %{
            title: "Kotlin",
            href: "https://kotlinlang.org/",
            description:
              "Just a better Java... but a lot better honestly."
          }
        ]
      },
      %{
        title: "Design",
        items: [
          %{
            title: "Figma",
            href: "https://www.figma.com/",
            description:
              "Simple (not generally easy) to use tool to get you started. I don't even remember what I used before, it's just as good."
          }
        ]
      },
      %{
        title: "Productivity",
        items: [
          %{
            title: "Toggl",
            href: "https://toggl.com",
            description:
              "I am a freelancer, keeping track of my time is important or I don't get payed. I tried a multitude of trackers but at the end always back at toggl."
          },
          %{
            title: "Todoist",
            href: "https://todoist.com",
            description:
              "My own TODO list for the \"quick\" things that must not be forgotten"
          },
          %{
            title: "Trello",
            href: "https://trello.com",
            description:
              "I am honestly not a big Jira fan, I find it abused in most companies for micromanaging teams. Trello on the other hand is really good to work in small teams or even on smaller private projects."
          },
        ]
      },
      %{
        title: "Freelancing",
        items: [
          %{
            title: "Bexio",
            href: "https://bexio.com",
            description:
              "Swiss Software for orders, invoices and all other related stuff. It also has a very good API which allows me to do a multitude of things."
          }
        ]
      },
    ]

    render(conn, :links, page_title: "Links - Rico Metzger", tool_sections: tool_sections)
  end

  def wip(conn, _params) do
    render(conn, :wip, page_title: "WIP - Rico Metzger")
  end
end
