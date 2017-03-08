defmodule Blog.Services.BrandingServiceTest do
  use Blog.ModelCase

  alias Blog.Branding
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

  test "generates a new branding changeset" do
    changeset = BrandingService.new_changeset()
    assert changeset.data == %Branding{}
    assert changeset.changes == %{}
  end

  test "generates a new branding changeset and includes params" do
    params = %{item: "foo", copy: "bar"}
    changeset = BrandingService.new_changeset(params)
    assert changeset.data == %Branding{}
    assert changeset.changes == params
  end

  test "creates a new record in the database" do
    params = %{item: "foo", copy: "bar"}
    {:ok, branding} = BrandingService.create(params)
    assert Repo.get_by(Branding, item: "foo") == branding
  end

  test "returns an error changeset when create fails" do
    params = %{item: "foo", copy: " "}
    {:error, changeset} = BrandingService.create(params)
    refute changeset.valid?
    assert Enum.count(changeset.errors) == 1
    assert Repo.get_by(Branding, item: "foo") == nil
  end
end
