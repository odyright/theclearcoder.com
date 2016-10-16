defmodule Blog.BrandingRepoTest do
  use Blog.ModelCase
  alias Blog.Branding

  @attrs %{item: "headline", copy: "Test headline"}

  test "converts unique_constraint on item to error" do
    insert_branding(%{item: "headline"})

    changeset = Branding.changeset(%Branding{}, @attrs)
    assert {:error, changeset} = Repo.insert(changeset)
    assert {:item, {"has already been taken", []}} in changeset.errors
  end
end
