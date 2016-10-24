defmodule Blog.Router do
  use Blog.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Blog.Auth, repo: Blog.Repo
  end

  scope "/", Blog do
    pipe_through :browser 

    # Used for letsencrypt
    get "/.well-known/acme-challenge/:content", PageController, :letsencrypt

    resources "/articles", ArticleController, param: "slug", 
                                              only: [:index, :show, :new, :create, :edit, :update, :delete]
    resources "/sessions", SessionController, only: [:new, :create, :delete]
    get "/info",           PageController, :info
    get "/",               PageController, :index
  end

  scope "/admin", Blog do
    pipe_through [:browser, :authenticate_user] 

    resources "/users", UserController, only: [:index, :show, :new, :create]
    resources "/branding", BrandingController, only: [:index, :show, :edit, :update]
  end
end
