defmodule Blog.Web.Router do
  use Blog.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Blog.Web.Auth, repo: Blog.Repo
  end

  scope "/", Blog.Web do
    pipe_through :browser 

    get "/.well-known/acme-challenge/:content", PageController, :letsencrypt
    get "/.well-known/keybase.txt",             PageController, :keybase

    resources "/articles", ArticleController, param: "slug", 
                                              only: [:index, :show, :new, :create, :edit, :update, :delete]
    resources "/sessions", SessionController, only: [:new, :create, :delete]
    resources "/podcast",  PodcastController, only: [:index, :show]    

    get "/feed/podcast.xml", FeedController, :podcast
    get "/info",           PageController, :info
    get "/projects",       PageController, :projects
    get "/",               PageController, :index
  end

  scope "/admin", Blog.Web do
    pipe_through [:browser, :authenticate_user] 

    resources "/users", UserController, only: [:index, :show, :new, :create]
    resources "/branding", BrandingController
  end
end
