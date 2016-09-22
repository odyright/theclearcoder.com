defmodule Blog.PageController do
  use Blog.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
  
  def contact(conn, _params) do
    render conn, "contact.html"
  end
  
  def articles(conn, _params) do
    render conn, "articles.html"
  end
end
