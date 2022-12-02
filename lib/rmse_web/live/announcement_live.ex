defmodule RmseWeb.AnnouncementLive do
  use RmseWeb, :live_view

  @self_update_cycle 1000

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: Process.send_after(self(), :update, @self_update_cycle)
    remaining_days = calculate_remaining_days()
    {:ok,
      socket
      |> assign(:remaining_days_german, format_german(remaining_days))
      |> assign(:remaining_days_english, format_english(remaining_days))
    }
  end

  @impl true
  def handle_info(:update, socket) do
    Process.send_after(self(), :update, @self_update_cycle)
    remaining_days = calculate_remaining_days()

    {:noreply,
      socket
      |> assign(:remaining_days_german, format_german(remaining_days))
      |> assign(:remaining_days_english, format_english(remaining_days))
    }
  end

  defp calculate_remaining_days do
    target = ~N[2022-11-08 00:00:00]
    now = NaiveDateTime.local_now()

    diff_in_second = NaiveDateTime.diff(target, now)

    minutes = div(diff_in_second, 60)
    hours = div(minutes, 60)
    days = div(hours, 24)

    hours_rem = hours - days * 24
    minutes_rem = minutes - days * 24 * 60 - hours_rem * 60

    {days, hours_rem, minutes_rem}
  end

  defp format_german({days, hours, minutes}) do
    days_string = if days > 0, do: "#{days} Tagen ", else: ""
    hours_string = if hours > 0 || days > 0, do: "#{hours} Stunden und ", else: ""
    "#{days_string}#{hours_string} #{minutes} Minuten"
  end
  defp format_english({days, hours, minutes}) do
    days_string = if days > 0, do: "#{days} days ", else: ""
    hours_string = if hours > 0 || days > 0, do: "#{hours} hours and ", else: ""
    "#{days_string}#{hours_string} #{minutes} minutes"
  end
end
