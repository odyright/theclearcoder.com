defmodule Blog.PodcastController do
  use Blog.Web, :controller

  alias Blog.Services.PodcastService

  def index(conn, _params) do
    render conn, "index.html", podcasts: PodcastService.list_podcasts()
  end

  def show(conn, %{"id" => id}) do
    render_podcast(conn, PodcastService.for_episode(id))
  end

  defp render_podcast(conn, nil) do
    conn
    |> put_status(:not_found)
    |> render(Blog.ErrorView, "404.html")
  end

  defp render_podcast(conn, podcast) do
    conn
    |> put_layout("podcast.html")
    |> render("show.html", podcast: podcast)
  end
end
