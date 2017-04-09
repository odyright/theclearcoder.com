defmodule Blog.Media do
  @moduledoc """
  A module that provides functions for accessing media related data.
  """

  import Ecto.Query
  alias Blog.{Repo, Media.Podcast}

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

  @doc """
  Returns the most recent publishing date.
  """
  def last_published_on() do
    podcast = last_podcast()
    unless is_nil(podcast), do: podcast.inserted_at
  end

  defp last_podcast() do
    Podcast
    |> order_by(desc: :inserted_at)
    |> select([:inserted_at])
    |> limit(1)
    |> Repo.one()
  end
end
