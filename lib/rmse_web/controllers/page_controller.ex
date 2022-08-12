defmodule RmseWeb.PageController do
  use RmseWeb, :controller

  def index(conn, _params) do
    remaining_days =
      Date.diff(Date.new!(2022, 09, 01), Date.utc_today())

    render(conn, "index.html", %{remaining_days: remaining_days})
  end
end
