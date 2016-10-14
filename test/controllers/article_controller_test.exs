defmodule Blog.ArticleControllerTest do
  use Blog.ConnCase

  test "GET /articles", %{conn: conn} do
    conn = get conn, "/articles"
    assert html_response(conn, 200) =~ "<title>Articles | Brian Gamble</title>"
  end

  test "GET /articles/:slug for a known article", %{conn: conn} do
    insert_article(%{slug: "new-beginnings", title: "New beginnings"})

    conn = get conn, "/articles/new-beginnings"
    assert html_response(conn, 200) =~ "<title>New beginnings | Brian Gamble</title>"
  end

  test "GET /articles/:slug for a bad article", %{conn: conn} do
    conn = get conn, "/articles/bad-article"
    assert html_response(conn, 404)
  end
end
