defmodule Blog.Services.ArticleService do
  @moduledoc """
  Service that provides the ability to access articles.
  """ 

  import Ecto.Query
  alias Blog.{Repo, Article}

  @doc """
  Returns a sorted, item ascending list of `Blog.Article`.
  """
  def list_articles() do
    Article 
    |> order_by(desc: :inserted_at)
    |> Repo.all()
  end

  @doc """
  Returns a `Blog.Article` given a slug.
  """
  def get_by_slug(slug) do
    Repo.get_by(Article, slug: slug)
  end
 
  @doc """
  Returns an article `Ecto.Changeset` with the given params.
  """
  def new_changeset(params \\ %{}) do
    Article.changeset(%Article{}, params)
  end

  @doc """
  Saves a new article record to the database.  Returns {:ok, `Blog.Article`} if
  successful, otherwise an {:error, `Ecto.Changeset`} that contains the errors.
  """
  def create(params) do
    params_with_date = Map.put(params, "inserted_at", Timepiece.now()) 

    Article.changeset(%Article{}, params_with_date)
    |> Repo.insert()
  end
end
