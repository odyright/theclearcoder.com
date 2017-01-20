defmodule Blog.ArticleController do
  use Blog.Web, :controller
  plug :authenticate_user when not action in [:index, :show]

  alias Blog.Article

  def index(conn, _params) do
    query = Article |> order_by(desc: :inserted_at)
    articles = Repo.all(query)
    render conn, "index.html", articles: articles
  end

  def show(conn, %{"slug" => slug}) do
    article = Repo.get_by(Article, slug: slug)
    render_article(conn, article)
  end

  defp render_article(conn, nil) do
    conn
    |> put_status(:not_found)
    |> render(Blog.ErrorView, "404.html")
  end

  defp render_article(conn, article) do
    render conn, "show.html", article: article
  end

  def new(conn, _) do
    changeset = Article.changeset(%Article{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"article" => article_params}) do
    article_params = Map.merge(article_params, %{"inserted_at" => Ecto.DateTime.utc()}) 
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

  def edit(conn, %{"slug" => slug}) do
    article = Repo.get_by!(Article, slug: slug)
    changeset = Article.changeset(article)
    render(conn, "edit.html", article: article, changeset: changeset)
  end

  def update(conn, %{"slug" => slug, "article" => article_params}) do 
    article = Repo.get_by!(Article, slug: slug)
    changeset = Article.changeset(article, article_params)
    case Repo.update(changeset) do 
      {:ok, article} ->
        conn
        |> put_flash(:info, "Article updated successfully.") 
        |> redirect(to: article_path(conn, :show, article.slug))
      {:error, changeset} ->
        render(conn, "edit.html", article: article, changeset: changeset)
    end 
  end

  def delete(conn, %{"slug" => slug}) do 
    article = Repo.get_by!(Article, slug: slug) 
    Repo.delete!(article)

    conn
    |> put_flash(:info, "Article deleted successfully.") 
    |> redirect(to: article_path(conn, :index))
  end
end
