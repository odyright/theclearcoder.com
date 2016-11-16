defmodule Blog.ArticleViewTest do
  use Blog.ConnCase
  alias Blog.ArticleView
  
  test "returns the page title for the index page" do
    assert ArticleView.page_title(:index, %{}) == "Articles"
  end

  test "returns the page title for the show page" do
    article = Fixtures.build(:article)
    assert ArticleView.page_title(:show, %{article: article}) == "Test Article"
  end

  test "truncates the page title when the article title is longer than 40 chars" do
    article = %Blog.Article{title: "I am really, really, really long title so please truncate me"}
    assert ArticleView.page_title(:show, %{article: article}) ==
      "I am really, really, really long title s..."
  end
end
