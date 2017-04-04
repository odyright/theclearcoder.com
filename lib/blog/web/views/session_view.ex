defmodule Blog.Web.SessionView do
  use Blog.Web, :view

  def page_title(_action, _assigns), do: "Sign in"
end
