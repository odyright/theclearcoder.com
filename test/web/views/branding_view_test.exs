defmodule Blog.BrandingViewTest do
  use Blog.ConnCase, async: true
  import Phoenix.View
  alias Blog.{BrandingView, Branding}

  test "return a generic title with no assigned branding" do
    assert BrandingView.page_title(:index, %{}) == "Branding"
  end

  test "return page title with branding" do
    branding = %Blog.Branding{item: "headline"}
    assert BrandingView.page_title(:show, %{branding: branding}) == "Branding: headline"
  end

  test "render new.html", %{conn: conn} do
    content = render_to_string(BrandingView, "new.html", 
                               conn: conn, changeset: Branding.changeset(%Branding{})) 
    assert content =~ "form"
    assert content =~ "name=\"branding[item]\""
    assert content =~ "name=\"branding[copy]\""
    assert content =~ "Create Branding"
  end

  test "render edit.html", %{conn: conn} do
    branding = Forge.saved_branding
    content = render_to_string(BrandingView, "edit.html", 
                               conn: conn, changeset: Branding.changeset(branding)) 
    assert content =~ "form"
    assert content =~ "value=\"#{branding.item}\""
    assert content =~ branding.copy
    assert content =~ "Update Branding"
  end
end
