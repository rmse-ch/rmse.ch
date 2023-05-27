defmodule RmseWeb.MotorcycleLive do
  use RmseWeb, :live_view

  import RmseWeb.SocialIconsComponent

  @impl true
  def handle_params(_params, uri, socket) do
    {:noreply, assign_request_path(socket, uri)}
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :page_title, gettext("Motorcycle") <> " - Rico Metzger")}
  end

  attr :language, :string, required: true

  def introduction(%{language: "de"} = assigns) do
    ~H"""
    <p>
      Bis 2016 war ich ein fleissiger Automobilist und erlebte die aus meiner Sicht
      damals noch schöne Zeit der Digitalisierung von Autos. Doch während der Technokrat
      in mir Freude daran hatte, kämpfte der Autofahrer mit dieser Entwicklung. Die Freude
      am Autofahren verschwand und so entschied ich mich spontan, die Zeit des Autofahrens
      zu beenden.
    </p>

    <p>
      Als nächstes ging es dann ziemlich geradlinig zu einem Motorradhändler in der Umgebung:
      <.link
        class="text-sm font-medium text-zinc-800 transition hover:text-teal-500 dark:text-zinc-200 dark:hover:text-teal-500"
        href="https://www.rgs-team.ch/de/index.html"
      >
        RGS Team in Bützberg
      </.link>. Dort erhielt ich die nötige Beratung, was es braucht, um von 4 auf 2 Reifen zu wechseln und kurze Zeit
      später sass ich auf dem ersten Motorrad. Und seither verbringe ich den grössten Teil meiner Reisezeit auf 2 Rädern.
    </p>

    <p>
      Wann immer ich freie Zeit finde und das Wetter nicht gerade einen Sturm bringt, nehme ich das Motorrad, entweder um von A
      nach B zu kommen oder einfach, um mit viel Spass irgendwo einen Hügel anzufahren.
    </p>
    """
  end

  def introduction(assigns) do
    ~H"""
    <p>
      A long, long time ago... in 2016, cars became more and more automated. And while this
      in general should help - for me it was not helpful at all. I was just
      more and more bored during drives and also not enjoying the
      car driving anymore. So I did what everyone should do in this situation:
      I sold my car.
    </p>

    <p>
      What may be not everyone should or will do: next I walked into a shop of
      motorcycles (<.link
        class="text-sm font-medium text-zinc-800 transition hover:text-teal-500 dark:text-zinc-200 dark:hover:text-teal-500"
        href="https://www.rgs-team.ch/de/index.html"
      >
        RGS Team in Bützberg
      </.link>)
      and asked what I need to get started. I got an explanation and within short time I was sitting on this two tires.
      Since then I never looked back.
    </p>

    <p>
      Whenever I find free time and the weather isn't deep winter or storm, I will
      take out the motorcycle and go out driving.
    </p>
    """
  end

  attr :language, :string, required: true

  def honda_text(%{language: "de"} = assigns) do
    ~H"""
    <p>
      Meine erste Maschine. Es war eine echt gute Maschine für jemanden, der
      gerade das erste Mal 2 Räder verloren hatte und war 1/2 Jahr lang ein treuer
      Begleiter. Dann wurde sie mir untreu und bevorzugte einen Bergbach meiner Wenigkeit
      und warf mich einfach ab.
    </p>
    """
  end

  def honda_text(assigns) do
    ~H"""
    <p>
      My starting point. It was a good bike for someone as me, who starts
      at that late in a stage and it served me well for around 1/2 year, before
      it decided that it prefers a small mountain river more than me and threw me off.
    </p>
    """
  end

  attr :language, :string, required: true

  def kawa_z1000(%{language: "de"} = assigns) do
    ~H"""
    <p>
      Kurz nach dem Crash mit der Honda kam die Fahrprüfung und ich brauchte ein neues Gefährt. Die Z-1000
      kam wie gerufen und wurde von mir intensiv in den nächsten 3-4 Jahren genutzt.
    </p>
    """
  end

  def kawa_z1000(assigns) do
    ~H"""
    <p>
      My follow up. Shortly after the crash mentioned above I had an exam so I needed something new. Luckily
      I got this motorcycle which I drove for quite some time.
    </p>
    """
  end

  attr :language, :string, required: true

  def kawa_h2_sx_se(%{language: "de"} = assigns) do
    ~H"""
    <p>
      Meine aktuelle Liebe. Von dem Moment als ich sie das 1. Mal gefahren habe, war sie ein
      sofortiges Wunschfahrzeug und als meine Z1000 ihre ersten Alters-Kilometer-Zicken zeigte,
      habe ich mir diese Maschine zugelegt. Und bis jetzt verhält sie sich genau so, wie ich es
      mir erwünscht habe: traumhaft.
    </p>
    """
  end

  def kawa_h2_sx_se(assigns) do
    ~H"""
    <p>
      My current love. The best motorcycle I had until now and I love driving around on it.
      Feels like endless power while also just being comfortable for using.
    </p>
    """
  end
end
