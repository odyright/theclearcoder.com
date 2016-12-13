defmodule Blog.BrandingViewTest do
  use ExUnit.Case
  alias Blog.BrandingView

  test "return a generic title with no assigned branding" do
    assert BrandingView.page_title(:index, %{}) == "Branding"
  end

  test "return page title with branding" do
    branding = %Blog.Branding{item: "headline"}
    assert BrandingView.page_title(:show, %{branding: branding}) == "Branding: headline"
  end
end
