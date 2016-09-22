defmodule Blog.PageControllerTest do
  use Blog.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "I'm Brian Gamble"
  end

  test "GET /articles", %{conn: conn} do
    conn = get conn, "/articles"
    assert html_response(conn, 200) =~ "New beginnings"
  end

  test "GET /info", %{conn: conn} do
    conn = get conn, "/info"
    assert html_response(conn, 200) =~ "About"
  end

  test "GET /articles/:slug for a known article", %{conn: conn} do
    conn = get conn, "/articles/new-beginnings"
    assert html_response(conn, 200) =~ "New beginnings"
  end

  test "GET /articles/:slug for a bad article", %{conn: conn} do
    conn = get conn, "/articles/bad-article"
    assert html_response(conn, 404)
  end
end
