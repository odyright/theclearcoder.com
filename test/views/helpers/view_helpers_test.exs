defmodule Blog.ViewHelpersTest do
  use ExUnit.Case
  alias Blog.ViewHelpers

  test "converts markdown to safe html" do
    assert ViewHelpers.to_html("Hello world") == {:safe, "<p>Hello world</p>\n"}
  end

  test "converts nil to an empty string" do
    assert ViewHelpers.to_html(nil) == ""
  end
end
