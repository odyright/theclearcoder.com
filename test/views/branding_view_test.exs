defmodule Blog.BrandingViewTest do
  use ExUnit.Case
  alias Blog.BrandingView

  test "returns page title for index page" do
    assert BrandingView.page_title(:index, %{}) == "Branding"
  end

  test "return page title with the item" do
    branding = %Blog.Branding{item: "headline"}
    assert BrandingView.page_title(:show, %{branding: branding}) == "Branding: headline"
  end
end
