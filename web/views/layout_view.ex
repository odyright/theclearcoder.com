defmodule Blog.LayoutView do
  use Blog.Web, :view

  def page_title(conn, assigns) do
    apply(view_module(conn), :page_title, [action_name(conn), assigns]) <> "Brian Gamble"
  end
end
