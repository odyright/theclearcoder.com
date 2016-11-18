defmodule Blog.PodcastView do
  use Blog.Web, :view
  import Blog.Helpers.DateView, only: [iso8601_date: 1, readable_date: 1]

  def page_title(_action, _assigns), do: "Podcast"
end
