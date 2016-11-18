defmodule Blog.PodcastController do
  use Blog.Web, :controller

  alias Blog.Podcast

  def index(conn, _params) do
    query = Podcast |> order_by(desc: :inserted_at)
    podcasts = Repo.all(query)
    render conn, "index.html", podcasts: podcasts
  end

  def show(conn, %{"id" => id}) do
    podcast = Repo.get_by(Podcast, episode: id)
    render_podcast(conn, podcast)
  end

  defp render_podcast(conn, nil) do
    conn
    |> put_status(:not_found)
    |> render(Blog.ErrorView, "404.html")
  end

  defp render_podcast(conn, podcast) do
    render conn, "show.html", podcast: podcast
  end
end
