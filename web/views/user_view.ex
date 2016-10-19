defmodule Blog.UserView do
  use Blog.Web, :view
  alias Blog.User

  def page_title(:index, _assigns), do: "Users | "
  def page_title(:show, assigns) do
    first_name(assigns.user) <> " | "
  end

  def first_name(%User{name: name}) do
    name
    |> String.split(" ")
    |> Enum.at(0)
  end
end
