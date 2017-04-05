defmodule Blog.WritingTest do
  use Blog.DataCase, async: true
  alias Blog.{Writing, Writing.Article}

  test "returns an empty list with no articles" do
    assert Writing.list_articles() == []
  end

  test "returns a sorted, date descending list of articles" do
    oldest = Forge.saved_article(inserted_at: Timepiece.days_ago(5))
    newest = Forge.saved_article
    assert Writing.list_articles() == [newest, oldest]
  end

  test "return nil with an unknown article" do
    assert Writing.get_by_slug("foo") == nil
  end

  test "returns the requested article" do
    article = Forge.saved_article
    assert Writing.get_by_slug(article.slug) == article
  end

  test "creates a new record in the database" do
    params = new_article_params()
    {:ok, article} = Writing.create(params)
    assert Timepiece.last_minute?(article.inserted_at)
  end

  test "returns an error changeset when create fails" do
    params = Map.put(new_article_params(), "content", "  ")
    {:error, changeset} = Writing.create(params)
    refute changeset.valid?
    assert Enum.count(changeset.errors) == 1
  end

  test "returns a edit article changeset" do
    article   = Forge.saved_article
    changeset = Writing.edit_changeset(article.slug)
    assert changeset.data == article
  end

  test "returns an edit article changeset with param changes" do
    article     = Forge.saved_article
    new_content = %{content: "Elixir in action"}
    changeset   = Writing.edit_changeset(article.slug, new_content)
    assert changeset.data == article
    assert changeset.changes == new_content
  end

  test "updates an existing record in the database" do
    article  = Forge.saved_article
    params   = %{content: "some new content"}
    {:ok, updated_article} = Writing.update(article.slug, params)
    assert updated_article.title == article.title
    assert updated_article.content == params.content
  end

  test "deletes an existing record in the database" do
    article = Forge.saved_article
    Writing.delete(article.slug)
    assert is_nil(Repo.get_by(Article, slug: article.slug))
  end

  defp new_article_params() do
    a = Forge.article
    %{"title" => a.title, "teaser" => a.teaser, "content" => a.content}
  end
end
