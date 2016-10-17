defmodule Blog.PageController do
  use Blog.Web, :controller

  def index(conn, _params) do
    branding = Repo.all(Blog.Branding)
    render conn, "index.html", branding: branding
  end
  
  def info(conn, _params) do
    render conn, "info.html"
  end
end
