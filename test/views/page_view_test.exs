defmodule Blog.PageViewTest do
  use Blog.ConnCase, async: true
  alias Blog.PageView

  test "returns the page title for the index page" do
    assert PageView.page_title(:index, []) == "Welcome | "
  end

  test "returns the page title for the info page" do
    assert PageView.page_title(:info, []) == "Info | "
  end
end
