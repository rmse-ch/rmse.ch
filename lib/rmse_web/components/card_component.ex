defmodule RmseWeb.CardComponent do
  use Phoenix.Component

  attr :rest, :global

  def chevron_right_icon(assigns) do
    ~H"""
    <svg viewBox="0 0 16 16" fill="none" aria-hidden="true" {@rest}>
      <path
        d="M6.75 5.75 9.25 8l-2.5 2.25"
        strokeWidth="1.5"
        strokeLinecap="round"
        strokeLinejoin="round"
      />
    </svg>
    """
  end

  attr :rest, :global
  slot :inner_block

  def card(assigns) do
    ~H"""
    <div class="group relative flex flex-col items-start">
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  attr :href, :string, required: true
  attr :rest, :global
  slot :inner_block

  def card_link(assigns) do
    ~H"""
    <div class="absolute -inset-y-6 -inset-x-4 z-0 scale-95 bg-zinc-50 opacity-0 transition group-hover:scale-100 group-hover:opacity-100 dark:bg-zinc-800/50 sm:-inset-x-6 sm:rounded-2xl" />
    <.link href={@href} {@rest}>
      <span class="absolute -inset-y-6 -inset-x-4 z-20 sm:-inset-x-6 sm:rounded-2xl" />
      <span class="relative z-10"><%= render_slot(@inner_block) %></span>
    </.link>
    """
  end

  attr :href, :string, required: false
  attr :rest, :global
  slot :inner_block

  def card_title(assigns) do
    ~H"""
    <h2 class="text-base font-semibold tracking-tight text-zinc-800 dark:text-zinc-100">
      <%= if @href do %>
        <.card_link href={@href}>
          <%= render_slot(@inner_block) %>
        </.card_link>
      <% else %>
        <%= render_slot(@inner_block) %>
      <% end %>
    </h2>
    """
  end

  slot :inner_block

  def card_description(assigns) do
    ~H"""
    <p class="relative z-10 mt-2 text-sm text-zinc-600 dark:text-zinc-400">
      <%= render_slot(@inner_block) %>
    </p>
    """
  end

  slot :inner_block

  def card_cta(assigns) do
    ~H"""
    <div
      aria-hidden="true"
      class="relative z-10 mt-4 flex items-center text-sm font-medium text-teal-500"
    >
      <%= render_slot(@inner_block) %> <.chevron_right_icon class="ml-1 h-4 w-4 stroke-current" />
    </div>
    """
  end

  attr :href, :string, required: false
  attr :decorate, :boolean, required: false, default: false
  attr :rest, :global

  slot :inner_block

  def card_eyebrow(assigns) do
    ~H"""
    <p
      class={"relative z-10 order-first mb-3 flex items-center text-sm text-zinc-400 dark:text-zinc-500 #{if @decorate, do: "pl-3.5"}"}
      {@rest}
    >
      <%= if @decorate do %>
        <span class="absolute inset-y-0 left-0 flex items-center" aria-hidden="true">
          <span class="h-4 w-0.5 rounded-full bg-zinc-200 dark:bg-zinc-500" />
        </span>
      <% end %>
      <%= render_slot(@inner_block) %>
    </p>
    """
  end
end
