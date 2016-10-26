defmodule Blog.UserView do
  use Blog.Web, :view

  def page_title(_action, _assigns), do: "Users | "
end
