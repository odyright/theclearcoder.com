defmodule Blog.UserControllerTest do
  use Blog.ConnCase

  test "requires user authentication on all actions", %{conn: conn} do
    Enum.each [
      get(conn, user_path(conn, :new)),
      get(conn, user_path(conn, :index)),
      get(conn, user_path(conn, :show, "1")),
      get(conn, user_path(conn, :create, %{}))
    ], fn conn ->
      assert html_response(conn, 302)
      assert conn.halted
    end
  end

  describe "with a logged in user" do
    setup do
      user = Fixtures.create(:user)
      conn = assign(build_conn(), :current_user, user)
      {:ok, conn: conn, user: user}
    end

    test "lists all users on index", %{conn: conn, user: user} do
      conn = get conn, user_path(conn, :index)
      assert html_response(conn, 200) =~ ~r/Listing Users/
      assert String.contains?(conn.resp_body, user.name)
    end

    test "shows the requested user", %{conn: conn, user: user} do
      conn = get conn, user_path(conn, :show, user.id)
      assert html_response(conn, 200) =~ ~r/Showing User/
      assert String.contains?(conn.resp_body, user.name)
    end

    test "presents the form to create a new user", %{conn: conn} do
      conn = get conn, user_path(conn, :new)
      assert html_response(conn, 200) =~ ~r/New User/
      assert String.contains?(conn.resp_body, "form")
    end
  end
end
