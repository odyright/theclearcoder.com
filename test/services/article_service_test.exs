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

  test "creates a new record in the database" do
    params = new_article_params()
    {:ok, article} = ArticleService.create(params)
    assert Timepiece.last_minute?(article.inserted_at)
    assert Repo.get_by(Article, slug: params["slug"]) == article
  end

  test "returns an error changeset when create fails" do
    params = Map.put(new_article_params(), "content", "  ")
    {:error, changeset} = ArticleService.create(params)
    refute changeset.valid?
    assert Enum.count(changeset.errors) == 1
    assert Repo.get_by(Article, slug: params["slug"]) == nil
  end

  defp new_article_params() do
    a = Forge.article
    %{"slug" => a.slug, "title" => a.title, "teaser" => a.teaser, "content" => a.content}
  end
end
