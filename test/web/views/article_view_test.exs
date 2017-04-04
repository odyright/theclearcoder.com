defmodule Blog.Web.ArticleViewTest do
  use Blog.Web.ConnCase, async: true
  import Phoenix.View
  alias Blog.{Web.ArticleView, Article}
  
  test "returns the page title for the index page" do
    assert ArticleView.page_title(:index, %{}) == "Articles"
  end

  test "returns the page title for the show page" do
    article = Forge.article
    assert ArticleView.page_title(:show, %{article: article}) == article.title
  end

  test "render new.html", %{conn: conn} do
    content = render_to_string(ArticleView, "new.html", 
                               conn: conn, changeset: Article.changeset(%Article{})) 
    assert content =~ "form"
    assert content =~ "name=\"article[title]\""
    assert content =~ "name=\"article[teaser]\""
    assert content =~ "name=\"article[content]\""
    assert content =~ "Create Article"
  end

  test "render edit.html", %{conn: conn} do
    article = Forge.saved_article
    content = render_to_string(ArticleView, "edit.html",
                               conn: conn, changeset: Article.changeset(article))
    assert content =~ "form"
    assert content =~ "value=\"#{article.title}\""
    assert content =~ "value=\"#{article.teaser}\""
    assert content =~ article.content
    assert content =~ "Update Article"
  end
end
