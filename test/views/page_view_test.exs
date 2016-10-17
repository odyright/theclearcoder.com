defmodule Blog.PageViewTest do
  use Blog.ConnCase, async: true
  alias Blog.PageView

  test "returns the page title for the index page" do
    assert PageView.page_title(:index, []) == "Welcome | "
  end

  test "returns the page title for the info page" do
    assert PageView.page_title(:info, []) == "Info | "
  end

  test "returns the headline as safe html" do
    assert PageView.headline([%Blog.Branding{item: "headline", copy: "# I'm Brian"}]) ==
       {:safe, "<h1>I’m Brian</h1>\n"}
  end

  test "returns the intro as safe html" do
    assert PageView.intro([%Blog.Branding{item: "intro", copy: "Hello"}]) ==
       {:safe, "<p>Hello</p>\n"}
  end

  test "returns the bio as safe html" do
    assert PageView.bio([%Blog.Branding{item: "bio", copy: "I write code"}]) ==
       {:safe, "<p>I write code</p>\n"}
  end
end
