defmodule Blog.BrandingCopyTest do
  use Blog.ModelCase, async: true
  alias Blog.Branding

  @valid_attrs %{item: "headline", copy: "I'm a developer"}

  test "changeset with valid attributes" do
    changeset = Branding.changeset(%Branding{}, @valid_attrs)
    assert changeset.valid?
  end

  test "item is required" do
    attrs = Dict.merge(@valid_attrs, %{item: " "})
    changeset = Branding.changeset(%Branding{}, attrs)
    refute changeset.valid?
  end

  test "copy is required" do
    attrs = Dict.merge(@valid_attrs, %{copy: " "})
    changeset = Branding.changeset(%Branding{}, attrs)
    refute changeset.valid?
  end
end
