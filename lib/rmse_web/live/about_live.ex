defmodule RmseWeb.AboutLive do
  use RmseWeb, :live_view

  import RmseWeb.SocialIconsComponent

  @impl true
  def handle_params(_params, uri, socket) do
    {:noreply, assign_request_path(socket, uri)}
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :page_title, gettext("About - Rico Metzger"))}
  end

  attr :language, :string, required: true

  defp about_content(%{language: "de"} = assigns) do
    ~H"""
    <h1 class="text-4xl font-bold tracking-tight text-zinc-800 dark:text-zinc-100 sm:text-5xl">
      Ich bin Rico Metzger, ein begeisterter freiberuflicher Software-Entwickler.
    </h1>

    <div class="mt-6 space-y-7 text-base text-zinc-600 dark:text-zinc-400">
      <p>
        Seit ich das erste Mal ein Auge auf Computer geworfen habe, sind sie aus meinem Leben nicht mehr wegzudenken.
        Zu Beginn mit einem Fokus auf Hardware bin ich schnell zur Softwareentwicklung übergegangen
        und konnte nie genug über neue Ideen in der Softwareentwicklung
        oder Software-Architektur lernen.
      </p>

      <p>
        Heutzutage beschäftige ich mich hauptsächlich mit der Entwicklung von Software mit DDD und idealerweise
        mit einer Event-Driven Architektur. Meiner persönlichen Erfahrung nach führt das Entkoppeln
        verschiedener Teile eines Monolithen in kleinere Teile (Microservices / Self Contained Services),
        welche asynchron mittels Business-Events miteinander kommunizieren, langfristig zu einer
        leichter wartbaren Software. Selbstverständlich sind dabei die Initialkosten nicht zu unterschätzen,
        aber sie helfen auch dabei, die Business Domäne besser zu verstehen.
      </p>
    </div>

    <h2 class="text-2xl font-bold tracking-tight text-zinc-800 dark:text-zinc-100 sm:text-3xl mt-9">
      Meine Geschichte der Programmiersprachen
    </h2>

    <div class="mt-6 space-y-7 text-base text-zinc-600 dark:text-zinc-400">
      <p>
        Meine ersten Projekte in der professionellen Softwareentwicklung waren im Bereich
        der OOP, hauptsächlich mit Java. Ich programmierte Java in Kombination mit den üblichen
        großen Frameworks (JavaEE, Spring) und manchmal mit kleineren Frameworks
        (Micronaut, Vaadin, Wicket). Java war einfach die Programmiersprache,
        die mir von allen Programmiersprachen zu dieser Zeit am besten gefiel.
      </p>

      <p>
        Dann lernte ich
        <.link
          class="text-sm font-medium text-zinc-800 transition hover:text-teal-500 dark:text-zinc-200 dark:hover:text-teal-500"
          href="https://scala-lang.org"
        >
          Scala
        </.link>
        kennen
        und dies eröffnete eine völlig neue Welt. Funktionale Programmierung und vor allem
        saubere unveränderliche Objekte auf der einen Seite, das Akka-Akteursmodell auf der anderen Seite
        und das Ganze komplettiert durch das gewaltige Ökosystem der Java-Bibliotheken - das war fantastisch.
        Die Lernkurve ist zwar höher als bei reinem Java, aber die mit diesem Stack entwickelten Programme
        waren sauberer, später leichter zu verstehen und einfacher zu warten. Aber es gab natürlich einen Haken:
        Scala ist nicht sehr populär (zumindest in der Schweiz).
      </p>

      <p>
        Meine momentanen Favoriten für Fullstack-Programmierung sind die Sprache
        <.link
          class="text-sm font-medium text-zinc-800 transition hover:text-teal-500 dark:text-zinc-200 dark:hover:text-teal-500"
          href="https://elixir-lang.org"
        >
          Elixir
        </.link>
        kombiniert mit dem
        <.link
          class="text-sm font-medium text-zinc-800 transition hover:text-teal-500 dark:text-zinc-200 dark:hover:text-teal-500"
          href="https://phoenixframework.org"
        >
          Phoenix Framework
        </.link>.
        Endlich bin ich in der Lage zu sein, Fullstack-Entwicklung zu betreiben, ohne 2 separate Sprachen oder einen seltsamen Transpiler
        verwenden zu müssen, und dabei die Stabilität der auf Aktoren basierenden (sehr alten) Erlang Virtual Machine (BEAM)
        zu erhalten, ist eine wunderbare Erfahrung. Etwas, das ich in dieser Form bei anderen Sprachen immer noch vermisse.
      </p>
    </div>
    """
  end

  defp about_content(assigns) do
    ~H"""
    <h1 class="text-4xl font-bold tracking-tight text-zinc-800 dark:text-zinc-100 sm:text-5xl">
      I'm Rico Metzger, an enthusiastic freelancing software engineer.
    </h1>

    <div class="mt-6 space-y-7 text-base text-zinc-600 dark:text-zinc-400">
      <p>
        Since the moment, computers entered my life, I could not be without them anymore.
        Beginning with hardware understanding I quickly shifted to software development
        and could never learn enough about new ideas in software engineering
        or software architecture.
      </p>

      <p>
        Nowadays I mainly embrace developing software using DDD and ideally
        using an event driven architecture. In my personal experience, decoulping
        different parts of a software into smaller parts using an event driven
        style leads to far easier maintenable software in the long run, even if
        the initial investment is higher.
      </p>
    </div>

    <h2 class="text-2xl font-bold tracking-tight text-zinc-800 dark:text-zinc-100 sm:text-3xl mt-9">
      History of my programming languages
    </h2>

    <div class="mt-6 space-y-7 text-base text-zinc-600 dark:text-zinc-400">
      <p>
        My first projects in professional software development were in the field
        of OOP, mainly with Java. I programmed Java combined with the normal
        big frameworks (JavaEE, Spring) and sometimes with smaller frameworks
        (Micronaut, Vaadin, Wicket). Java at this time was the programming language
        that I liked most.
      </p>

      <p>
        Then I learned to know
        <.link
          class="text-sm font-medium text-zinc-800 transition hover:text-teal-500 dark:text-zinc-200 dark:hover:text-teal-500"
          href="https://scala-lang.org"
        >
          Scala
        </.link>
        and this opened a complete new world. Functional Programming and especially
        clean immutable objects on one side, the Akka actor model on the other side
        while having the full ecosystem of Java Libraries was something I admired.
        While the learning curve is higher than pure Java, the programs developed with
        this stack were cleaner, easier to understand later on and easier to maintain.
        There was naturally a catch though: Scala is not very popular (at least in Switzerland).
      </p>

      <p>
        My current most beloved language for web application development is
        <.link
          class="text-sm font-medium text-zinc-800 transition hover:text-teal-500 dark:text-zinc-200 dark:hover:text-teal-500"
          href="https://elixir-lang.org"
        >
          Elixir
        </.link>
        combined with the
        <.link
          class="text-sm font-medium text-zinc-800 transition hover:text-teal-500 dark:text-zinc-200 dark:hover:text-teal-500"
          href="https://phoenixframework.org"
        >
          Phoenix Framework
        </.link>. The idea of finally
        being able to do fullstack development without having to use 2 separate languages
        or some strange transpiler, while keeping the stability of the actor based (very old)
        Erlang virtual machine (BEAM) is a wonderful experience. Something I still miss
        on other languages.
      </p>
    </div>
    """
  end
end
