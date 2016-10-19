defmodule Blog.Router do
  use Blog.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", Blog do
    pipe_through :browser 

    # Used for letsencrypt
    get "/.well-known/acme-challenge/:content", PageController, :letsencrypt

    get "/articles",       ArticleController, :index
    get "/articles/:slug", ArticleController, :show

    get "/info",           PageController, :info
    get "/",               PageController, :index
  end

  scope "/admin", Blog do
    pipe_through :browser 

    get "/users",     UserController, :index
    get "/users/:id", UserController, :show
  end
end
