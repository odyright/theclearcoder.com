defmodule Blog.PageControllerTest do
  use Blog.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "I'm Brian Gamble"
  end

  test "GET /info", %{conn: conn} do
    conn = get conn, "/info"
    assert html_response(conn, 200) =~ "About"
  end
end
