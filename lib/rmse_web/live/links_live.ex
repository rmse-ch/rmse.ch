defmodule RmseWeb.LinksLive do
  use RmseWeb, :live_view

  @impl true
  def handle_params(_params, uri, socket) do
    {:noreply, assign_request_path(socket, uri)}
  end

  @impl true
  def mount(_params, _session, socket) do
    # TODO: move this the database for more comfort
    tool_sections = [
      %{
        title: "Programming Languages",
        items: [
          %{
            title: "Elixir",
            href: "https://elixir-lang.org/",
            description_en: """
            My absolute favourite at the time being. The stability and concurrency of the BEAM combined with a modern, easy to handle functional programming language.
            And for hardware near or system near programming, I can use Rustler with Rust.
            """,
            description_de: """
            Im Moment meine Programmiersprache Nummer 1. Sie bringt die Stabilität und das Aktorenmodell der Erlang BEAM VM zusammen mit einer modernen, einfach verständlichen funktionalen Programmierung.
            Und dank dem Ökosystem bietet sie einige grossartige Anbindungen wie das Phoenixframework oder Rustler. All das dann auch noch kombiniert mit einer grossartigen Community.
            """
          },
          %{
            title: "Rust",
            href: "https://www.rust-lang.org/",
            description_en:
              "System near programming at a new level. Once adapted to the compile time error messages, it's a really fun to use language.",
            description_de:
              "Systemnahe Programmierung auf einem komplett neuen Level. Hat man sich erst einmal an die Fehlermeldungen beim Kompilieren gewöhnt, ist es eine sehr angenehm zu verwendende Programmiersprache."
          },
          %{
            title: "Scala",
            href: "https://www.scala-lang.org/",
            description_en:
              "My favourite programming language on the JVM with better standard library than Java and most important: functional programming.",
            description_de:
              "Funktionale Programmierung auf der JVM, deutlich verbesserte Standard-Library gegenüber Java. Mein JVM-Favorit."
          },
          %{
            title: "Python",
            href: "https://python.org",
            description_en:
              "A really good programming language for getting things done quickly. Naturally also used widely in the data world.",
            description_de:
              "Eine der am einfachsten zu lernenden Programmiersprachen und aus dem ML/AI Bereich nicht wegzudenken."
          },
          %{
            title: "Kotlin",
            href: "https://kotlinlang.org/",
            description_en: "How Java should be (in my opinion).",
            description_de: "Moderne Java-Programmierung, ein (deutlich) besseres Java."
          },
          %{
            title: "Java",
            href: "https://dev.java/",
            description_en:
              "Beside the JVM which enables the huge ecosystem, it's still a good programming language.",
            description_de:
              "Totgesagte leben länger, immer noch eine gute Programmiersprache und eines der grössten Ökosysteme in der Welt der Programmierung."
          }
        ]
      },
      %{
        title: "Productivity / Freelancing",
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
            description: "My own TODO list for the \"quick\" things that must not be forgotten"
          },
          %{
            title: "Trello",
            href: "https://trello.com",
            description:
              "I am honestly not a big Jira fan, I find it abused in most companies for micromanaging teams. Trello on the other hand is really good to work in small teams or even on smaller private projects."
          },
          %{
            title: "Bexio",
            href: "https://bexio.com",
            description:
              "Swiss Software for orders, invoices and all other related stuff. It also has a very good API which allows me to do a multitude of things."
          },
          %{
            title: "DEV.to",
            href: "https://dev.to",
            description: "My favourite blog for developers and it's free."
          },
          %{
            title: "Medium",
            href: "https://medium.com",
            description: "Another really good blog for developers, unfortunately not free."
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
          },
          %{
            title: "Figma",
            href: "https://www.figma.com/",
            description:
              "Simple (not generally easy) to use tool to get you started. I don't even remember what I used before, it's just as good."
          }
        ]
      },
      %{
        title: "Hardware",
        items: [
          %{
            title: "Apple MacBook Pro",
            href: "https://www.apple.com/chde/macbook-pro-13/",
            description: """
            I tried hard with Windows but since using the MacBook Pro for development, I could never find myself comfortable anymore.
            It's just more comfortable, feels more easy to work with and the tooling is great. Now whenever I can I will switch to M2
            """
          }
        ]
      }
    ]

    {:ok,
     socket
     |> assign(:page_title, gettext("Links - Rico Metzger"))
     |> assign(:tool_sections, tool_sections)}
  end

  def description_in_right_language(_language, nil), do: nil

  def description_in_right_language(language, %{
        description_de: description_de,
        description_en: description_en
      }) do
    if language == "de" do
      description_de
    else
      description_en
    end
  end

  def description_in_right_language(_language, %{description: description}), do: description
end
