defmodule Blog.Services.PodcastService do
  @moduledoc """
  A module that provides functions for accessing `Blog.Podcast` data.
  """

  import Ecto.Query
  alias Blog.{Repo, Podcast}

  @doc """
  Returns a sorted, date descending list of `Blog.Podcast`.
  """
  def list_podcasts() do
    Podcast 
    |> order_by(desc: :inserted_at)
    |> Repo.all()
  end

  @doc """
  Returns the `Blog.Podcast` given an episode number.
  """
  def for_episode(number) do
    Repo.get_by(Podcast, episode: number)
  end
end
