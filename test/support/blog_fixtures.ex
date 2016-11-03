defmodule Blog.Fixtures do
  alias Blog.Repo

  def create(schema) do
    build(schema)
    |> Repo.insert!()
  end

  def build(:article) do
    {:ok, datetime} = Ecto.DateTime.cast(~N{2016-05-20 12:34:10})
    %Blog.Article{slug: "test-article", title: "Test Article",
                  teaser: "The best article you'll ever read!",
                  content: "Hello world!", inserted_at: datetime}
  end

  def build(:branding) do
    %Blog.Branding{item: "heading", copy: "I'm Brian Gamble"}
  end
end
