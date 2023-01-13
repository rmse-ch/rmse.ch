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

  attr :rest, :global, doc: "the arbitrary HTML attributes to add to the arrow down svg"
  def mail_icon(assigns) do
    ~H"""
      <svg
        viewBox="0 0 24 24"
        fill="none"
        strokeWidth="1.5"
        strokeLinecap="round"
        strokeLinejoin="round"
        aria-hidden="true"
        {@rest}
      >
        <path
          d="M2.75 7.75a3 3 0 0 1 3-3h12.5a3 3 0 0 1 3 3v8.5a3 3 0 0 1-3 3H5.75a3 3 0 0 1-3-3v-8.5Z"
          className="fill-zinc-100 stroke-zinc-400 dark:fill-zinc-100/10 dark:stroke-zinc-500"
        />
        <path
          d="m4 6 6.024 5.479a2.915 2.915 0 0 0 3.952 0L20 6"
          className="stroke-zinc-400 dark:stroke-zinc-500"
        />
      </svg>
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
end
