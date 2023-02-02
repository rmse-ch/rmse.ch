defmodule RmseWeb.Router do
  use RmseWeb, :router

  alias RmseWeb.LanguageOnMount

  alias Plug.Conn

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_live_flash)
    plug(:put_root_layout, {RmseWeb.Layouts, :root})
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(:fill_in_current_path)
    plug(RmseWeb.Plugs.Locale, "en")
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :strapi_webhook do
    plug(:accepts, ["json"])
    plug(:check_strapi_authorization)
  end

  scope "/", RmseWeb do
    pipe_through(:strapi_webhook)

    post("/strapi-webhook", StrapiWebhook, :strapi)
  end

  scope "/", RmseWeb do
    pipe_through(:browser)

    live_session :default, on_mount: [LanguageOnMount] do
      live("/", IndexLive)
      live("/about", AboutLive)
      live("/motorcycle", MotorcycleLive)
      live("/links", LinksLive)

      live("/apps", WIPLive, :apps)
      live("/projects", WIPLive, :projects)
      live("/blog", BlogLive.Index)
      live("/blog/:slug", BlogLive.Show)

      live("/conditions", WIPLive, :conditions)
      live("/contact", WIPLive, :contact)
      live("/cookies", WIPLive, :cookies)
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", RmseWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:rmse, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through(:browser)

      live_dashboard("/dashboard", metrics: RmseWeb.Telemetry)
      forward("/mailbox", Plug.Swoosh.MailboxPreview)
    end
  end

  defp fill_in_current_path(%Conn{assigns: assigns, request_path: request_path} = conn, _opts) do
    %{conn | assigns: Map.put(assigns, :request_path, request_path)}
  end

  # simple authorization using a fake bearer token which is also in the environment variables.
  # should be good enough for my use-case.
  defp check_strapi_authorization(conn, _opts) do
    validate_authorization_header(conn, Conn.get_req_header(conn, "authorization"))
  end

  defp validate_authorization_header(conn, []), do: unauthorized(conn)

  defp validate_authorization_header(conn, ["Bearer " <> token | tl]) do
    cond do
      token == strapi_token() -> conn
      true -> validate_authorization_header(conn, tl)
    end
  end

  defp validate_authorization_header(conn, [_hd | tl]),
    do: validate_authorization_header(conn, tl)

  defp validate_authorization_header(conn, _), do: unauthorized(conn)

  defp unauthorized(conn), do: conn |> Conn.send_resp(401, "\"unauthorized\"") |> Conn.halt()

  defp strapi_token, do: Application.fetch_env!(:rmse, :strapi_token)
end
