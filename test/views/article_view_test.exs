defmodule Blog.ArticleViewTest do
  use ExUnit.Case
  alias Blog.ArticleView
  
  @article %Blog.Article{created_on: ~N{2016-05-20 12:34:10}}

  test "returns the created on date as iso8601" do
    assert ArticleView.date_as_iso8601(@article) == "2016-05-20T12:34:10"
  end

  test "return the created on date as a readable string" do
    assert ArticleView.date_as_readable(@article) == "May 20, 2016"
  end
end
