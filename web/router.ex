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
    # Use the default browser stack
    pipe_through :browser 

    get "/articles",       ArticleController, :index
    get "/articles/:slug", ArticleController, :show

    get "/info",           PageController, :info
    get "/",               PageController, :index
  end
end
