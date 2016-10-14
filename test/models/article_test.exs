defmodule Blog.ArticleTest do
  use Blog.ModelCase, async: true
  alias Blog.Article

  @valid_attrs %{slug: "hello-world", title: "Hello, World", teaser: "click here", 
                 content: "test, test, test", inserted_at: Ecto.DateTime.utc()}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Article.changeset(%Article{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Article.changeset(%Article{}, @invalid_attrs)
    refute changeset.valid?
  end
end
