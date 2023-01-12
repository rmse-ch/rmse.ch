defmodule RmseWeb.IndexLiveTest do
  use RmseWeb.ConnCase

  import Phoenix.LiveViewTest

  describe "Index" do
    test "shows the start page", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/")

      assert html =~ "Rico Metzger"
    end
  end
end
