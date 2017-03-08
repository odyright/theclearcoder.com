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

  test "should get the articles page", %{conn: conn} do
    article = Forge.saved_article
    conn = get conn, article_path(conn, :index)
    response = html_response(conn, 200)
    assert response =~ "Articles"
    assert response =~ article.title
  end

  test "should display a message when there a no articles", %{conn: conn} do
    conn = get conn, article_path(conn, :index)
    assert html_response(conn, 200) =~ "No articles posted"
  end

  test "should show the details of a saved article", %{conn: conn} do
    article = Forge.saved_article
    conn = get conn, "/articles/#{article.slug}"
    assert html_response(conn, 200) =~ article.title
  end

  test "returns 404 when trying to access an unknown article", %{conn: conn} do
    conn = get conn, "/articles/bad-article"
    assert response(conn, 404)
  end
end
