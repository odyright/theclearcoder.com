defmodule Blog.ArticleTest do
  use Blog.ModelCase, async: true
  alias Blog.Article

  @valid_attrs %{slug: "hello-world", 
                 title: "Hello, World", 
                 teaser: "click here", 
                 content: "test, test, test"}

  test "changeset with valid attributes" do
    changeset = Article.changeset(%Article{}, @valid_attrs)
    assert changeset.valid?
  end

  test "slug is required" do
    changeset = changeset_with_blank(:slug)
    refute changeset.valid?
  end

  test "title is required" do
    changeset = changeset_with_blank(:title)
    refute changeset.valid?
  end

  test "teaser is required" do
    changeset = changeset_with_blank(:teaser)
    refute changeset.valid?
  end

  test "content is required" do
    changeset = changeset_with_blank(:content)
    refute changeset.valid?
  end

  defp changeset_with_blank(key) do
    attrs = Map.merge(@valid_attrs, %{key => " "})
    Article.changeset(%Article{}, attrs)
  end
end
