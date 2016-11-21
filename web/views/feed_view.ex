defmodule Blog.FeedView do
  use Blog.Web, :view

  import Blog.Helpers.DateView, only: [iso8601_date: 1]
end
