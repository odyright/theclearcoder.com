defmodule Blog.BrandingCopyTest do
  use Blog.ModelCase, async: true
  alias Blog.Branding

  @valid_attrs %{item: "headline", copy: "I'm a developer"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Branding.changeset(%Branding{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Branding.changeset(%Branding{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "returns the requested copy from a list of content" do
    branding = %Branding{item: "headline", copy: "I'm a developer"}
    assert Branding.get_copy([branding], "headline") == "I'm a developer"
  end
end
