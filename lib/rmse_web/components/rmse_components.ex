defmodule RmseWeb.RmseComponents do
  @moduledoc """
  Provides specialized functionality for my homepage.
  """
  use Phoenix.Component

  @variant_styles %{
    primary:
      "bg-zinc-800 font-semibold text-zinc-100 hover:bg-zinc-700 active:bg-zinc-800 active:text-zinc-100/70 dark:bg-zinc-700 dark:hover:bg-zinc-600 dark:active:bg-zinc-700 dark:active:text-zinc-100/70",
    secondary:
      "bg-zinc-50 font-medium text-zinc-900 hover:bg-zinc-100 active:bg-zinc-100 active:text-zinc-900/60 dark:bg-zinc-800/50 dark:text-zinc-300 dark:hover:bg-zinc-800 dark:hover:text-zinc-50 dark:active:bg-zinc-800/50 dark:active:text-zinc-50/70",
  }

  @doc """
  Renders an arrow down symbol

  ## Examples

    <.arrow-down />
  """

  attr :rest, :global, doc: "the arbitrary HTML attributes to add to the arrow down svg"

  def arrow_down(assigns) do
    ~H"""
      <svg viewBox="0 0 16 16" fill="none" aria-hidden="true" {@rest}>
        <path
          d="M4.75 8.75 8 12.25m0 0 3.25-3.5M8 12.25v-8.5"
          strokeWidth="1.5"
          strokeLinecap="round"
          strokeLinejoin="round"
        />
      </svg>
    """
  end

  @doc """
  Renders a social link

  ## Examples

    <.social-link icon={linkedin} />
  """

  attr :href, :string, required: true
  attr :rest, :global, doc: "the arbitrary HTML attributes to add to the arrow down svg"
  slot :inner_block, doc: "the optional inner block that renders the icon"

  def social_link(assigns) do
    ~H"""
      <.link class="group -m-1 p-1" href={@href} {@rest}>
        <div class="h-6 w-6 fill-zinc-500 transition group-hover:fill-zinc-600 dark:fill-zinc-400 dark:group-hover:fill-zinc-300">
          <%= render_slot(@inner_block) %>
        </div>
      </.link>
    """
  end

  attr :class, :string, required: false, default: ""
  attr :href, :string, required: true
  slot :icon, required: true
  slot :inner_block
  def social_link_big(assigns) do
    ~H"""
      <li class={"#{@class} flex"}>
        <.link
          href={@href}
          class="group flex text-sm font-medium text-zinc-800 transition hover:text-teal-500 dark:text-zinc-200 dark:hover:text-teal-500"
        >
          <div class="h-6 w-6 flex-none fill-zinc-500 transition group-hover:fill-teal-500">
            <%= render_slot(@icon) %>
          </div>
          <span class="ml-4"><%= render_slot(@inner_block) %></span>
        </.link>
      </li>
    """
  end

  attr :class, :string, required: false, default: ""
  attr :rest, :global, doc: "the arbitrary HTML attributes to add to the arrow down svg"
  slot :inner_block, doc: "the optional inner block that renders the icon"

  def outer_container(assigns) do
    ~H"""
      <div class={"sm:px-8 #{@class}"} {@rest}>
        <div class="mx-auto max-w-7xl lg:px-8">
          <%= render_slot(@inner_block) %>
        </div>
      </div>
    """
  end

  attr :rest, :global, doc: "the arbitrary HTML attributes to add to the arrow down svg"
  slot :inner_block, doc: "the optional inner block that renders the icon"

  def inner_container(assigns) do
    ~H"""
      <div class="relative px-4 sm:px-8 lg:px-12" {@rest}>
        <div class="mx-auto max-w-2xl lg:max-w-5xl">
          <%= render_slot(@inner_block) %>
        </div>
      </div>
    """
  end

  attr :rest, :global, doc: "the arbitrary HTML attributes to add to the arrow down svg"
  slot :inner_block, doc: "the optional inner block that renders the icon"

  def container(assigns) do
    ~H"""
      <.outer_container {@rest}>
        <.inner_container>
          <%= render_slot(@inner_block) %>
        </.inner_container>
      </.outer_container>
    """
  end

  attr :class, :string, required: false, default: ""
  attr :variant, :atom, required: false, default: :primary
  attr :href, :string, required: false, default: nil
  attr :rest, :global

  slot :inner_block

  def rmse_button(assigns) do
    ~H"""
      <%= if @href do %>
        <.link href={@href} class={class_button(@class, @variant)} {@rest}><%= render_slot(@inner_block) %></.link>
      <% else %>
        <button class={class_button(@class, @variant)} {@rest}><%= render_slot(@inner_block) %></button>
      <% end %>
    """
  end

  defp class_button(class, variant) do
    "inline-flex items-center gap-2 justify-center rounded-md py-2 px-3 text-sm outline-offset-2 transition active:transition-none #{@variant_styles[variant]} #{class}"
  end

  attr :title, :string, required: true

  slot :inner_block

  def section(assigns) do
    ~H"""
      <%!-- aria-labelledby={id} --%>
      <section
        class="md:border-l md:border-zinc-100 md:pl-6 md:dark:border-zinc-700/40"
      >
        <div class="grid max-w-3xl grid-cols-1 items-baseline gap-y-8 md:grid-cols-3">
          <%!-- id={id} --%>
          <h2
            class="text-sm font-semibold text-zinc-800 dark:text-zinc-100"
          >
            <%= @title %>
          </h2>
          <div class="md:col-span-2"><%= render_slot(@inner_block) %></div>
        </div>
      </section>
    """
  end

end
