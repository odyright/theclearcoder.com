defmodule Blog.Web.ArticleController do
  use Blog.Web, :controller
  plug :authenticate_user when not action in [:index, :show]

  alias Blog.Writing

  def index(conn, _params) do
    conn
    |> render("index.html", articles: Writing.list_articles())
  end

  def show(conn, %{"slug" => slug}) do
    Writing.get_by_slug(slug)
    |> render_article(conn)
  end

  def new(conn, _params) do
    conn
    |> render("new.html", changeset: Writing.new_changeset())
  end

  def create(conn, %{"article" => params}) do
    case Writing.create(params) do
      {:ok, article} ->
        conn
        |> put_flash(:info, "#{article.title} created!")
        |> redirect(to: article_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"slug" => slug}) do
    conn
    |> render("edit.html", changeset: Writing.edit_changeset(slug))
  end

  def update(conn, %{"slug" => slug, "article" => article_params}) do 
    case Writing.update(slug, article_params) do
      {:ok, article} ->
        conn
        |> put_flash(:info, "Article updated successfully.") 
        |> redirect(to: article_path(conn, :show, article.slug))
      {:error, changeset} ->
        render(conn, "edit.html", changeset: changeset)
    end 
  end

  def delete(conn, %{"slug" => slug}) do 
    Writing.delete(slug)

    conn
    |> put_flash(:info, "Article deleted successfully.") 
    |> redirect(to: article_path(conn, :index))
  end

  defp render_article(nil, conn) do
    conn
    |> put_status(:not_found)
    |> render(Blog.Web.ErrorView, "404.html")
  end

  defp render_article(article, conn) do
    render conn, "show.html", article: article
  end
end
