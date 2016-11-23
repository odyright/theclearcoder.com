defmodule Blog.FeedController do
  use Blog.Web, :controller
  alias Blog.Podcast

  def podcast(conn, _params) do
    query = Podcast |> order_by(desc: :inserted_at)
    podcasts = Repo.all(query)
    latest_podcast = podcasts |> List.first

    conn
    |> put_layout(false)
    |> put_resp_content_type("application/rss+xml")
    |> render("podcast.rss", podcasts: podcasts, latest_podcast: latest_podcast)
  end
end
