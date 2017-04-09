defmodule Blog.Web.PodcastController do
  use Blog.Web, :controller

  alias Blog.Media

  def index(conn, _params) do
    render conn, "index.html", podcasts: Media.list_podcasts()
  end

  def show(conn, %{"id" => id}) do
    render_podcast(conn, Media.for_episode(id))
  end

  defp render_podcast(conn, nil) do
    conn
    |> put_status(:not_found)
    |> render(Blog.Web.ErrorView, "404.html")
  end

  defp render_podcast(conn, podcast) do
    conn
    |> put_layout("podcast.html")
    |> render("show.html", podcast: podcast)
  end
end
