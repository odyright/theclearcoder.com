defmodule Blog.Helpers.HtmlViewTest do
  use ExUnit.Case
  alias Blog.Helpers.HtmlView

  test "converts markdown to safe html" do
    assert HtmlView.to_html("Hello world") == {:safe, "<p>Hello world</p>\n"}
  end

  test "converts nil to an empty string" do
    assert HtmlView.to_html(nil) == ""
  end
end
