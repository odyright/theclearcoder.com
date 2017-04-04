defmodule Blog.Web.FeedView do
  use Blog.Web, :view

  import Blog.Web.Helpers.DateView, only: [iso8601_date: 1]
end
