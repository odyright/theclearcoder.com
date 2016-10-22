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
end