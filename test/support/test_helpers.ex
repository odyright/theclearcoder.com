defmodule Blog.TestHelpers do
  alias Blog.Repo

  def insert_article(attrs \\ %{}) do
    changes = Dict.merge(%{
      slug: "test-article",
      title: "Test Article",
      teaser: "The best article you'll ever read!",
      content: "Hello world!",
      inserted_at: Ecto.DateTime.utc()
    }, attrs)

    %Blog.Article{}
    |> Blog.Article.changeset(changes)
    |> Repo.insert!()
  end
end
