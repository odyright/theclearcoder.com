defmodule Blog.ArticleRepoTest do
  use Blog.ModelCase
  alias Blog.Article

  @attrs %{slug: "my-test", title: "My Test", teaser: "click here", 
           content: "test, test, test", inserted_at: Ecto.DateTime.utc()}

  test "converts unique_constraint on slug to error" do
    Fixtures.create(:article)

    new_article = Fixtures.build(:article)
    changeset = Article.changeset(new_article)
    assert {:error, changeset} = Repo.insert(changeset)
    assert {:slug, {"has already been taken", []}} in changeset.errors
  end
end
