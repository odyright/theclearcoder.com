defmodule Blog.PageControllerTest do
  use Blog.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "I'm Brian Gamble"
  end

  test "GET /articles", %{conn: conn} do
    conn = get conn, "/articles"
    assert html_response(conn, 200) =~ "Under construction"
  end

  test "GET /info", %{conn: conn} do
    conn = get conn, "/info"
    assert html_response(conn, 200) =~ "About"
  end
end
