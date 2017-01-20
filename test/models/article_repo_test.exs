defmodule Blog.ArticleRepoTest do
  use Blog.ModelCase
  alias Blog.Article

  test "converts unique_constraint on slug to error" do
    Fixtures.create(:article)

    new_article = Fixtures.build(:article)
    changeset = Article.changeset(new_article)
    assert {:error, changeset} = Repo.insert(changeset)
    assert {:slug, {"has already been taken", []}} in changeset.errors
  end
end
