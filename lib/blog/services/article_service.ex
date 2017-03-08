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
end
