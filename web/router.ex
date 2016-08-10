defmodule Chatbox.Router do
  use Chatbox.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :browser_session do
    plug Guardian.Plug.VerifySession # look in session for token
    plug Guardian.Plug.EnsureAuthenticated, handler: Chatbox.SessionController
    plug Guardian.Plug.LoadResource
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug Guardian.Plug.VerifyHeader # look in authorization header for token
    plug Guardian.Plug.LoadResource
  end

  scope "/", Chatbox do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController, only: [:new, :create]
    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end

  scope "/", Chatbox do
    pipe_through [:browser, :browser_session]

    get "/chat", ChatController, :index
    resources "/users", UserController, only: [:show, :index, :update]
  end

  # Other scopes may use custom stacks.
  # scope "/api", Chatbox do
  #   pipe_through :api
  # end
end
