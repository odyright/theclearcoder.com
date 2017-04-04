defmodule Blog.Web.PageViewTest do
  use Blog.Web.ConnCase, async: true
  alias Blog.Web.PageView

  @copy %{"headline" => "# I'm Brian"}

  test "returns the page title for the index page" do
    assert PageView.page_title(:index, []) == "Welcome"
  end

  test "returns the page title for the info page" do
    assert PageView.page_title(:info, []) == "Info"
  end

  test "returns the page title for the projects page" do
    assert PageView.page_title(:projects, []) == "Projects"
  end

  test "returns branding copy as safe html", %{conn: conn} do
    conn = assign_copy(conn) 
    assert PageView.html_copy(conn, "headline") == {:safe, "<h1>I’m Brian</h1>\n"}
  end

  test "returns an empty string if branding copy doesn't exist", %{conn: conn} do
    conn = assign_copy(conn)
    assert PageView.html_copy(conn, "foo") == ""
  end

  defp assign_copy(conn), do: assign(conn, :copy, @copy)
end
