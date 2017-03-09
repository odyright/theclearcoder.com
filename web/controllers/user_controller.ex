defmodule Blog.UserController do
  use Blog.Web, :controller
  alias Blog.Services.UserService

  def index(conn, _params) do
    conn
    |> render("index.html", users: UserService.list_users())
  end

  def show(conn, %{"id" => id}) do
    conn
    |> render("show.html", user: UserService.get_by_id(id))
  end

  def new(conn, _params) do
    conn
    |> render("new.html", changeset: UserService.new_changeset())
  end

  def create(conn, %{"user" => params}) do
    case UserService.create(params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "#{user.name} created!")
        |> redirect(to: user_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
