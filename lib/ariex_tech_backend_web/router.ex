defmodule AriexTechBackendWeb.Router do
  use AriexTechBackendWeb, :router

  import AriexTechBackendWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {AriexTechBackendWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AriexTechBackendWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  scope "/api", AriexTechBackendWeb do
    pipe_through :api

    resources "/posts", PostController, except: [:new, :edit, :create]
  end

  # Other scopes may use custom stacks.
  # scope "/api", AriexTechBackendWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:ariex_tech_backend, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:browser,:require_authenticated_user]

      live_dashboard "/dashboard", metrics: AriexTechBackendWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", AriexTechBackendWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    get "/users/log_in", UserSessionController, :new
    post "/users/log_in", UserSessionController, :create
  end

  scope "/", AriexTechBackendWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/users/settings", UserSettingsController, :edit
    put "/users/settings", UserSettingsController, :update
    get "/users/settings/confirm_email/:token", UserSettingsController, :confirm_email
  end

  scope "/", AriexTechBackendWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete
    get "/users/confirm", UserConfirmationController, :new
    post "/users/confirm", UserConfirmationController, :create
    get "/users/confirm/:token", UserConfirmationController, :edit
    post "/users/confirm/:token", UserConfirmationController, :update
  end
end
