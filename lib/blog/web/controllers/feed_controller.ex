defmodule Blog.FeedController do
  use Blog.Web, :controller

  alias Blog.Services.PodcastService

  def podcast(conn, _params) do
    conn
    |> put_layout(false)
    |> put_resp_content_type("application/rss+xml")
    |> render("podcast.rss", 
              podcasts:       PodcastService.list_podcasts(), 
              last_published: PodcastService.last_published_on())
  end
end
