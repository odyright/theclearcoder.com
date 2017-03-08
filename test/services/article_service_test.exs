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

  test "return nil with an unknown article" do
    assert ArticleService.get_by_slug("foo") == nil
  end

  test "returns the requested article" do
    article = Forge.saved_article
    assert ArticleService.get_by_slug(article.slug) == article
  end
end
