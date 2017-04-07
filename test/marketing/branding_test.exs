defmodule Blog.Marketing.BrandingTest do
  use Blog.DataCase, async: true
  alias Blog.Marketing.Branding

  @valid_attrs %{item: "headline", copy: "I'm a developer"}

  test "changeset with valid attributes" do
    changeset = Branding.changeset(%Branding{}, @valid_attrs)
    assert changeset.valid?
  end

  test "item is required" do
    changeset = changeset_with_blank(:item)
    refute changeset.valid?
  end

  test "copy is required" do
    changeset = changeset_with_blank(:copy)
    refute changeset.valid?
  end

  defp changeset_with_blank(key) do
    attrs = Map.merge(@valid_attrs, %{key => " "})
    Branding.changeset(%Branding{}, attrs)
  end
end
