defmodule Blog.PageController do
  use Blog.Web, :controller

  def index(conn, _params) do
    render conn, "index.html", branding: branding()
  end
  
  def info(conn, _params) do
    render conn, "info.html", branding: branding()
  end

  defp branding do
    Repo.all(Blog.Branding)
  end
end
