defmodule Blog.PageControllerTest do
  use Blog.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "I'm Brian Gamble"
  end

  test "GET /contact", %{conn: conn} do
    conn = get conn, "/contact"
    assert html_response(conn, 200) =~ "Email"
  end

  test "GET /articles", %{conn: conn} do
    conn = get conn, "/articles"
    assert html_response(conn, 200) =~ "Under construction"
  end
end
