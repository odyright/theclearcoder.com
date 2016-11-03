defmodule Blog.ArticleViewTest do
  use Blog.ConnCase
  alias Blog.ArticleView
  
  setup do
    {:ok, article: Fixtures.build(:article)}
  end

  test "returns the created on date as iso8601", %{article: article} do
    assert ArticleView.date_as_iso8601(article) == "2016-05-20T12:34:10"
  end

  test "return the created on date as a readable string", %{article: article} do
    assert ArticleView.date_as_readable(article) == "May 20, 2016"
  end

  test "returns the page title for the index page" do
    assert ArticleView.page_title(:index, %{}) == "Articles"
  end

  test "returns the page title for the show page", %{article: article} do
    assert ArticleView.page_title(:show, %{article: article}) == "Test Article"
  end

  test "truncates the page title when the article title is longer than 40 chars" do
    article = %Blog.Article{title: "I am really, really, really long title so please truncate me"}
    assert ArticleView.page_title(:show, %{article: article}) ==
      "I am really, really, really long title s..."
  end
end
