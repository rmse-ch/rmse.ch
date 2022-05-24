defmodule RmseWeb.PageController do
  use RmseWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
