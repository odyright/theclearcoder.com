defmodule Blog.Web.UserController do
  use Blog.Web, :controller
  alias Blog.{Admin, Admin.User}

  def index(conn, _params) do
    users = Admin.list_users()
    render(conn, "index.html", users: users)
  end

  def show(conn, %{"id" => id}) do
    user = Admin.get_user(id)
    render(conn, "show.html", user: user)
  end

  def new(conn, _params) do
    changeset = User.new_changeset()
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => params}) do
    case Admin.create_user(params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "#{user.name} created!")
        |> redirect(to: user_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
