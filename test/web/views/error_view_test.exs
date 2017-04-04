defmodule Blog.Web.ErrorViewTest do
  use Blog.Web.ConnCase, async: true
  alias Blog.Web.ErrorView

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders 404.html" do
    assert render_to_string(ErrorView, "404.html", []) ==
           "404 - Page not found"
  end

  test "render 500.html" do
    assert render_to_string(ErrorView, "500.html", []) ==
           "Internal server error"
  end

  test "render any other" do
    assert render_to_string(ErrorView, "505.html", []) ==
           "Internal server error"
  end

  test "renders page title for error page" do
    assert ErrorView.page_title(nil, %{}) == "An error occurred"
  end
end
