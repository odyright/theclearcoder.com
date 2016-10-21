defmodule Blog.ArticleController do
  use Blog.Web, :controller
  plug :authenticate_user when action in [:new, :create]

  alias Blog.Article

  def index(conn, _params) do
    articles = Repo.all(Article)
    render conn, "index.html", articles: articles
  end

  def show(conn, %{"slug" => slug}) do
    article = Repo.get_by(Article, slug: slug)
    render_article(conn, article)
  end

  def new(conn, _) do
    changeset = Article.changeset(%Article{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"article" => article_params}) do
    article_params = Dict.merge(%{"inserted_at" => Ecto.DateTime.utc()}, article_params) 
    changeset = Article.changeset(%Article{}, article_params)
    case Repo.insert(changeset) do
      {:ok, article} ->
        conn
        |> put_flash(:info, "#{article.title} created!")
        |> redirect(to: article_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  defp render_article(conn, nil) do
    conn
    |> put_status(:not_found)
    |> render(Blog.ErrorView, "404.html")
  end

  defp render_article(conn, article) do
    render conn, "show.html", article: article
  end
end
