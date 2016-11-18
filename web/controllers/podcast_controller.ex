defmodule Blog.PodcastController do
  use Blog.Web, :controller

  alias Blog.Podcast

  def index(conn, _params) do
    query = Podcast |> order_by(desc: :inserted_at)
    podcasts = Repo.all(query)
    render conn, "index.html", podcasts: podcasts
  end
end
