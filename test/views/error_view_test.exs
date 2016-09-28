defmodule Blog.ErrorViewTest do
  use Blog.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders 404.html" do
    assert render_to_string(Blog.ErrorView, "404.html", []) ==
           "404 - Page not found"
  end

  test "render 500.html" do
    assert render_to_string(Blog.ErrorView, "500.html", []) ==
           "Internal server error"
  end

  test "render any other" do
    assert render_to_string(Blog.ErrorView, "505.html", []) ==
           "Internal server error"
  end

  test "renders page title for error page" do
    assert Blog.ErrorView.page_title(nil, %{}) == "An error occurred | "
  end
end
