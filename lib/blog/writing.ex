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
  def get_by_slug(slug) do
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
  Returns an `Ecto.Changeset` loaded with the `Blog.Writing.Article` specified by the slug.  If
  new parameters are given, they will be contained in the changes.
  """
  def edit_changeset(slug, params \\ %{}) do
    get_by_slug(slug)
    |> Article.changeset(params)
  end

  @doc """
  Updates an existing article record in the database.  Returns {:ok, `Blog.Writing.Article`} if
  successful, otherwise an {:error, `Ecto.Changeset`} that contains the errors.
  """
  def update(slug, params) do
    edit_changeset(slug, params)
    |> Repo.update() 
  end

  @doc """
  Delete an article record in the database given the slug.
  """
  def delete(slug) do
    get_by_slug(slug)
    |> Repo.delete!()
  end
end
