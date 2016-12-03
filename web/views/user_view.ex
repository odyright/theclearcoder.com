defmodule Blog.UserView do
  use Blog.Web, :view

  def page_title(:index, _assigns), do: "Users"
  def page_title(:new, _assigns), do: "Users"
  def page_title(_action, assigns) do
    "User: #{assigns.user.username}"
  end
end
