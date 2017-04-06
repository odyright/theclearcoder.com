defmodule Blog.Writing do
  @moduledoc """
  Service that provides the ability to access articles.
  """ 

  import Ecto.Query
  alias Blog.{Repo, Writing.Article}

  @doc """
  Returns a sorted, item ascending list of `Blog.Writing.Article`.
  """
  def list_articles() do
    Article 
    |> order_by(desc: :inserted_at)
    |> Repo.all()
  end

  @doc """
  Returns a `Blog.Writing.Article` given a slug.
  """
  def get_article(slug) do
    Repo.get_by(Article, slug: slug)
  end
 
  @doc """
  Saves a new article record to the database.  Returns {:ok, `Blog.Writing.Article`} if
  successful, otherwise an {:error, `Ecto.Changeset`} that contains the errors.
  """
  def create(params) do
    params_with_date = Map.put(params, "inserted_at", Timepiece.now()) 

    Article.changeset(%Article{}, params_with_date)
    |> Repo.insert()
  end

  @doc """
  Takes a `Blog.Writing.Article` and updates it given the new parameters.  Returns 
  {:ok, `Blog.Writing.Article`} if successful, otherwise an {:error, `Ecto.Changeset`} 
  that contains the errors.
  """
  def update_article(article, changes) do
    article
    |> Article.changeset(changes)
    |> Repo.update() 
  end

  @doc """
  Delete an article record in the database given the slug.
  """
  def delete(slug) do
    get_article(slug)
    |> Repo.delete!()
  end
end
