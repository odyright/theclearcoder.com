defmodule Blog.PageViewTest do
  use Blog.ConnCase, async: true
  alias Blog.PageView

  test "returns the page title for the index page" do
    assert PageView.page_title(:index, []) == "Welcome"
  end

  test "returns the page title for the info page" do
    assert PageView.page_title(:info, []) == "Info"
  end

  test "returns branding copy as safe html" do
    assert PageView.html_copy([%Blog.Branding{item: "headline", copy: "# I'm Brian"}], "headline") ==
       {:safe, "<h1>I’m Brian</h1>\n"}
  end
end
