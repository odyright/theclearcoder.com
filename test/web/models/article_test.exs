defmodule Blog.ArticleTest do
  use Blog.DataCase, async: true
  alias Blog.Article

  @valid_attrs %{"title"   => "Hello, World!", 
                 "teaser"  => "click here", 
                 "content" => "test, test, test"}

  test "changeset with valid attributes" do
    changeset = Article.changeset(%Article{}, @valid_attrs)
    assert changeset.valid?
  end

  test "title is required" do
    changeset = changeset_with_blank("title")
    refute changeset.valid?
  end

  test "a slug is generated from the title" do
    changeset = Article.changeset(%Article{}, @valid_attrs)
    assert changeset.changes.slug == "hello-world"
    
    changeset = Article.changeset(%Article{title: "Another way", teaser: "foo", content: "bar"})
    assert changeset.changes.slug == "another-way"
  end

  test "teaser is required" do
    changeset = changeset_with_blank("teaser")
    refute changeset.valid?
  end

  test "content is required" do
    changeset = changeset_with_blank("content")
    refute changeset.valid?
  end

  defp changeset_with_blank(key) do
    attrs = Map.merge(@valid_attrs, %{key => " "})
    Article.changeset(%Article{}, attrs)
  end
end
