defmodule Blog.Writing.ArticleRepoTest do
  use Blog.DataCase
  alias Blog.Writing.Article

  test "converts unique_constraint on slug to error" do
    article = Forge.saved_article
    new_article = Forge.article(title: article.title)

    changeset = Article.changeset(new_article)
    assert {:error, changeset} = Repo.insert(changeset)
    assert {:slug, {"has already been taken", []}} in changeset.errors
  end
end
