defmodule RmseWeb.Router do
  use RmseWeb, :router

  alias RmseWeb.PreferencesOnMount

  alias Plug.Conn

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {RmseWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fill_in_current_path
    plug :store_language
    plug :store_dark_mode
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RmseWeb do
    pipe_through :browser

    live_session :default, on_mount: [PreferencesOnMount] do
      live "/", IndexLive
      live "/about", AboutLive
      live "/motorcycle", MotorcycleLive
      live "/links", LinksLive

      live "/apps", WIPLive, :apps
      live "/projects", WIPLive, :projects
      live "/blog", WIPLive, :blog

      live "/agb", WIPLive, :agb
      live "/contact", WIPLive, :contact
      live "/cookies", WIPLive, :cookies
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
      pipe_through :browser

      live_dashboard "/dashboard", metrics: RmseWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  defp fill_in_current_path(%Conn{assigns: assigns, request_path: request_path} = conn, _opts) do
    %{conn | assigns: Map.put(assigns, :request_path, request_path)}
  end

  defp store_language(%Conn{params: params} = conn, _opts) do
    case Map.get(params, "lang") do
      nil -> conn
      lang -> put_session(conn, :lang, lang)
    end
  end

  defp store_dark_mode(%Conn{params: params} = conn, _opts) do
    case Map.get(params, "dark_mode") do
      nil ->
        conn

      dark_mode ->
        put_session(conn, :dark_mode, dark_mode)
    end
  end
end
