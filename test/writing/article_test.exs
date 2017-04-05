defmodule Blog.Writing.ArticleTest do
  use Blog.DataCase, async: true
  alias Blog.Writing.Article

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

  test "generates a new article changeset" do
    changeset = Article.new_changeset()
    assert changeset.data == %Article{}
    assert changeset.changes == %{}
  end

  test "generates a new article changeset and includes params" do
    params = new_article_params()
    changeset = Article.new_changeset(params)
    assert changeset.data == %Article{}
    assert Enum.count(changeset.changes) == 4
    assert changeset.changes.title == params["title"]
  end

  defp changeset_with_blank(key) do
    attrs = Map.merge(@valid_attrs, %{key => " "})
    Article.changeset(%Article{}, attrs)
  end

  defp new_article_params() do
    a = Forge.article
    %{"title" => a.title, "teaser" => a.teaser, "content" => a.content}
  end
end
