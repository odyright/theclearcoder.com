defmodule Blog.Web.UserController do
  use Blog.Web, :controller
  alias Blog.Admin

  def index(conn, _params) do
    conn
    |> render("index.html", users: Admin.list_users())
  end

  def show(conn, %{"id" => id}) do
    conn
    |> render("show.html", user: Admin.get_by_id(id))
  end

  def new(conn, _params) do
    conn
    |> render("new.html", changeset: Admin.new_changeset())
  end

  def create(conn, %{"user" => params}) do
    case Admin.create(params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "#{user.name} created!")
        |> redirect(to: user_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
