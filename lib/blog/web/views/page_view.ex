defmodule Blog.Web.PageView do
  use Blog.Web, :view

  def page_title(:index, _assigns), do: "Welcome"
  def page_title(:info, _assigns), do: "Info"
  def page_title(:projects, _assigns), do: "Projects"

  def html_copy(conn, name) do
    conn.assigns.copy
    |> Map.get(name)
    |> to_html
  end
end
