defmodule Blog.ArticleController do
  use Blog.Web, :controller

  def index(conn, _params) do
    articles = Repo.all(Blog.Article)
    render conn, "index.html", articles: articles
  end

  def show(conn, %{"slug" => slug}) do
    article = Repo.get_by(Blog.Article, slug: slug)
    render_article(conn, article)
  end

  def render_article(conn, nil) do
    conn
    |> put_status(:not_found)
    |> render(Blog.ErrorView, "404.html")
  end

  def render_article(conn, article) do
    render conn, "show.html", article: article
  end
end
