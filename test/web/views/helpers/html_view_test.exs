defmodule Blog.Web.Helpers.HtmlViewTest do
  use ExUnit.Case, async: true
  alias Blog.Web.Helpers.HtmlView

  test "converts markdown to safe html" do
    assert HtmlView.to_html("Hello world") == {:safe, "<p>Hello world</p>\n"}
  end

  test "converts nil to an empty string" do
    assert HtmlView.to_html(nil) == ""
  end

  test "returns a page title" do
    assert HtmlView.title("") == {:safe, "<title>Brian Gamble</title>"}
    assert HtmlView.title("Test Article") == {:safe, "<title>Test Article | Brian Gamble</title>"}
  end

  test "returns a truncated page title when longer than 40 chars" do
    text = "I am really, really, really long title so please truncate me"
    assert HtmlView.title(text) ==
      {:safe, "<title>I am really, really, really long title s... | Brian Gamble</title>"}
  end
end
