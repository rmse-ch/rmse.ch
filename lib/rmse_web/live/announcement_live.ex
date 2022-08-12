defmodule RmseWeb.AnnouncementLive do
  use RmseWeb, :live_view

  @self_update_cycle 10000

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: Process.send_after(self(), :update, @self_update_cycle)
    {:ok, assign(socket, :remaining_days, calculate_remaining_days())}
  end

  @impl true
  def handle_info(:update, socket) do
    Process.send_after(self(), :update, @self_update_cycle)
    {:noreply, assign(socket, :remaining_days, calculate_remaining_days())}
  end

  defp calculate_remaining_days do
    "some more days"
  end
end
