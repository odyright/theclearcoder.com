defmodule Blog.UserView do
  use Blog.Web, :view

  def page_title(_action, assigns) do
    if Map.has_key?(assigns, :user) do
      "User: #{assigns.user.username}"
    else
      "Users"
    end
  end
end
