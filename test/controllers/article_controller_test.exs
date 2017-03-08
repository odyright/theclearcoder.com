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

  describe "with a logged in user" do
    setup :login_test_user

    test "displays the new branding form with the new action", %{conn: conn} do
      conn     = get conn, article_path(conn, :new)
      response = html_response(conn, 200)

      assert response =~ "New Article"
      assert response =~ "form"
    end

    test "successful create redirects and sets a flash message", %{conn: conn} do
      params = new_article()
      conn = post conn, article_path(conn, :create, %{"article" => params})

      assert response(conn, 302) =~ article_path(conn, :index)
      assert get_flash(conn, :info) == "#{params.title} created!"
    end

    test "failed create will display an error message", %{conn: conn} do
      params = Map.put(new_article(), "teaser", " ")
      conn = post conn, article_path(conn, :create, %{"article" => params})

      assert html_response(conn, 200) =~ "check the errors below"
    end

    test "displays an edit branding form with the edit action", %{conn: conn} do
      article  = Forge.saved_article
      conn     = get(conn, article_path(conn, :edit, article.slug))
      response = html_response(conn, 200)

      assert response =~ "Edit Article"
      assert response =~ article.title
    end

    test "successful update redirects and sets a flash message", %{conn: conn} do
      article = Forge.saved_article
      conn = put conn, article_path(conn, :update, article.slug,
                                     %{"article" => %{"content" => "new content"}})

      assert response(conn, 302) =~ article_path(conn, :show, article.slug)
      assert get_flash(conn, :info) =~ "Article updated successfully"
    end

    test "failed update will display an error message", %{conn: conn} do
      article = Forge.saved_article
      conn = put conn, article_path(conn, :update, article.slug,
                                     %{"article" => %{"content" => "  "}})
      
      assert html_response(conn, 200) =~ "check the errors below"
    end

    test "delete redirects and sets a flash message", %{conn: conn} do
      article = Forge.saved_article
      conn = delete conn, article_path(conn, :delete, article.slug)

      assert response(conn, 302) =~ article_path(conn, :index)
      assert get_flash(conn, :info) =~ "Article deleted successfully"
    end
  end

  defp new_article() do
    %{slug: "foo", title: "Unsubscribe", teaser: "It's the story of the year!", content: "It's gripping!"}
  end
end
