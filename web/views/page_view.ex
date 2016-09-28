defmodule Blog.PageView do
  use Blog.Web, :view

  def page_title(:index, _assigns), do: "Welcome | "
  def page_title(:info, _assigns), do: "Info | "
end
