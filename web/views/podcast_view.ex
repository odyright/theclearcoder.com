defmodule Blog.PodcastView do
  use Blog.Web, :view
  import Blog.Helpers.DateView, only: [date_as_iso8601: 1, date_as_readable: 1]

  def page_title(_action, _assigns), do: "Podcast"
end
