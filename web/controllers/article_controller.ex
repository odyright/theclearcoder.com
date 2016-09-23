defmodule Blog.ArticleController do
  use Blog.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def show(conn, %{"slug" => slug}) do
    render_article(conn, slug)
  end

  def render_article(conn, "new-beginnings") do
    render conn, "show.html"
  end

  def render_article(conn, _slug) do
    conn
    |> put_status(:not_found)
    |> render(Blog.ErrorView, "404.html")
  end
end
