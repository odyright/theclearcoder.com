defmodule Blog.ArticleControllerTest do
  use Blog.ConnCase

  test "GET /articles", %{conn: conn} do
    conn = get conn, "/articles"
    assert html_response(conn, 200) =~ "New beginnings"
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
