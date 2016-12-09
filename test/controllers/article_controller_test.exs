defmodule Blog.ArticleControllerTest do
  use Blog.ConnCase

  test "authentication required for new, create, edit, update, delete", %{conn: conn} do
    Enum.each [
      get(conn, article_path(conn, :new)),
      post(conn, article_path(conn, :create, %{})),
      get(conn, article_path(conn, :edit, "1")),
      put(conn, article_path(conn, :update, "1", %{})),
      delete(conn, article_path(conn, :delete, "1"))
    ], fn conn ->
      assert html_response(conn, 302)
      assert conn.halted
    end
  end

  test "GET /articles", %{conn: conn} do
    conn = get conn, "/articles"
    assert html_response(conn, 200) =~ "Articles"
  end

  test "GET /articles/:slug for a known article", %{conn: conn} do
    article = Fixtures.create(:article)

    conn = get conn, "/articles/test-article"
    assert html_response(conn, 200) =~ article.title
  end

  test "GET /articles/:slug for a bad article", %{conn: conn} do
    conn = get conn, "/articles/bad-article"
    assert html_response(conn, 404)
  end
end
