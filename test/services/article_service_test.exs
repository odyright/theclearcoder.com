defmodule Blog.Services.ArticleServiceTest do
  use Blog.ModelCase
  alias Blog.Services.ArticleService

  test "returns an empty list with no articles" do
    assert ArticleService.list_articles() == []
  end

  test "returns a sorted, date descending list of articles" do
    oldest = Forge.saved_article(inserted_at: Timepiece.days_ago(5))
    newest = Forge.saved_article
    assert ArticleService.list_articles() == [newest, oldest]
  end
end
