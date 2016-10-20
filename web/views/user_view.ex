defmodule Blog.UserView do
  use Blog.Web, :view
  alias Blog.User

  def page_title(_action, _assigns), do: "Users | "

  def first_name(%User{name: name}) do
    name
    |> String.split(" ")
    |> Enum.at(0)
  end
end
