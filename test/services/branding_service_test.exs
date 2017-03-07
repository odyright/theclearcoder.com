defmodule Blog.Services.BrandingServiceTest do
  use Blog.ModelCase
  alias Blog.Services.BrandingService

  test "returns an empty map with no branding" do
    assert BrandingService.get_copy() == %{}
  end

  test "returns the branding content as a map" do
    foo = Forge.saved_branding(item: "foo")
    bar = Forge.saved_branding(item: "bar")
    assert BrandingService.get_copy() == %{
      "foo" => foo.copy,
      "bar" => bar.copy
    }
  end

  test "returns an empty list with no branding" do
    assert BrandingService.list_branding() == []
  end

  test "returns a branding list sorted by item" do
    foo = Forge.saved_branding(item: "foo")
    bar = Forge.saved_branding(item: "bar")
    assert BrandingService.list_branding() == [ bar, foo ]
  end

  test "returns nil when trying to retrieve a brand that doesn't exist" do
    assert BrandingService.get_by_id(1) == nil
  end

  test "return the branding record by the id" do
    branding = Forge.saved_branding
    assert BrandingService.get_by_id(branding.id) == branding
  end
end
