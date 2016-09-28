defmodule Blog.ArticleViewTest do
  use ExUnit.Case
  alias Blog.ArticleView
  
  @article %Blog.Article{title: "Test article", created_on: ~N{2016-05-20 12:34:10}}

  test "returns the created on date as iso8601" do
    assert ArticleView.date_as_iso8601(@article) == "2016-05-20T12:34:10"
  end

  test "return the created on date as a readable string" do
    assert ArticleView.date_as_readable(@article) == "May 20, 2016"
  end

  test "returns the page title for the index page" do
    assert ArticleView.page_title(:index, %{}) == "Articles | "
  end

  test "returns the page title for the show page" do
    assert ArticleView.page_title(:show, %{article: @article}) == "Test article | "
  end
end
