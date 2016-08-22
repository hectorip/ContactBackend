defmodule Contactapi.Router do
  use Contactapi.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Contactapi.Auth, repo: Contactapi.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug CORSPlug, origin: ["*"]
  end

  scope "/", Contactapi do
    pipe_through :browser # Use the default browser stack

    resources "/sessions", SessionController, only: [:new, :create, :delete]
    resources "/users", UserController, only: [:index, :show, :new, :create]
    get "/", PageController, :index
  end

  scope "/admin", Contactapi do
    pipe_through [:browser, :authenticate_user]
    resources "/basicforms", BasicFormController
     resources "/volunteerforms", VolunteerFormController
  end
  # Other scopes may use custom stacks.
  scope "/api", Contactapi do
    pipe_through :api
    post "/basicforms/new", BasicFormController, :create_api
  end
end
