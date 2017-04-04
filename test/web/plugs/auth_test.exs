defmodule Blog.Web.AuthTest do
  use Blog.Web.ConnCase, async: true
  alias Blog.{Web.Auth, Repo}

  setup %{conn: conn} do
    conn =
      conn
      |> bypass_through(Blog.Web.Router, :browser)
      |> get("/")
    {:ok, %{conn: conn}}
  end

  test "should specify the repo" do

    repo = Auth.init(foo: "bar", repo: Blog.Repo)
    assert repo == Blog.Repo

    assert_raise KeyError, fn ->
      Auth.init(foo: "bar")
    end
  end

  test "authenticate_user halts when no current_user exists", %{conn: conn} do
    conn = Auth.authenticate_user(conn, [])
    assert conn.halted
  end

  test "authenticate_user continues when the current_user exists", %{conn: conn} do
    conn =
      conn
      |> assign(:current_user, %Blog.User{})
      |> Auth.authenticate_user([])
    
    refute conn.halted
  end

  test "login puts the user in the session", %{conn: conn} do
    login_conn =
      conn
      |> Auth.login(%Blog.User{id: 123})
      |> send_resp(:ok, "")

    next_conn = get(login_conn, "/")
    assert get_session(next_conn, :user_id) == 123
  end

  test "logout drops the session", %{conn: conn} do
    logout_conn =
      conn
      |> put_session(:user_id, 123)
      |> Auth.logout()
      |> send_resp(:ok, "")

    next_conn = get(logout_conn, "/")
    refute get_session(next_conn, :user_id)
  end

  test "call places user from session into assigns", %{conn: conn} do
    user = Forge.saved_user
    conn =
      conn
      |> put_session(:user_id, user.id)
      |> Auth.call(Repo)

    assert conn.assigns.current_user.id == user.id
  end

  test "call with no session sets current_user assign to nil", %{conn: conn} do
    conn = Auth.call(conn, Repo)
    assert conn.assigns.current_user == nil
  end

  test "login with a valid username and pass", %{conn: conn} do
    user = Forge.saved_user
    {:ok, conn} = Auth.login_by_username_and_pass(conn, user.username, "password", repo: Repo)

    assert conn.assigns.current_user.id == user.id
    assert conn.assigns.current_user.username == user.username
  end

  test "login with a not found user", %{conn: conn} do
    assert {:error, :not_found, _conn} =
      Auth.login_by_username_and_pass(conn, "me", "secret", repo: Repo)
  end

  test "login with password mismatch", %{conn: conn} do
    user = Forge.saved_user
    assert {:error, :unauthorized, _conn} =
      Auth.login_by_username_and_pass(conn, user.username, "incorrect", repo: Repo)
  end
end
