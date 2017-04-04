defmodule Blog.LayoutView do
  use Blog.Web, :view
  import Blog.Helpers.HtmlView, only: [title: 1]

  def page_title(conn, assigns) do
    apply(view_module(conn), :page_title, [action_name(conn), assigns]) 
    |> title()
  end
end
