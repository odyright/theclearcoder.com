defmodule Blog.Web.FeedController do
  use Blog.Web, :controller

  alias Blog.Media

  def podcast(conn, _params) do
    conn
    |> put_layout(false)
    |> put_resp_content_type("application/rss+xml")
    |> render("podcast.rss", 
              podcasts:       Media.list_podcasts(), 
              last_published: Media.last_published_on())
  end
end
