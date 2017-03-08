defmodule Blog.Services.ArticleServiceTest do
  use Blog.ModelCase
  alias Blog.Article
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

  test "generates a new article changeset" do
    changeset = ArticleService.new_changeset()
    assert changeset.data == %Article{}
    assert changeset.changes == %{}
  end

  test "generates a new article changeset and includes params" do
    params = %{title: "a new one", teaser: "foo"}
    changeset = ArticleService.new_changeset(params)
    assert changeset.data == %Article{}
    assert changeset.changes == params
  end
end
