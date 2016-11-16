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
end
