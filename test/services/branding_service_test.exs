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
end
