defmodule Blog.PageController do
  use Blog.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
  
  def articles(conn, _params) do
    render conn, "articles.html"
  end

  def info(conn, _params) do
    render conn, "info.html"
  end

  def show(conn, _params) do
    render conn, "show.html"
  end
end
