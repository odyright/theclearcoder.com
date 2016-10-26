defmodule Blog.LayoutView do
  use Blog.Web, :view

  def page_title(conn, assigns) do
    title = apply(view_module(conn), :page_title, [action_name(conn), assigns]) 
    "#{title} | Brian Gamble"
  end
end
