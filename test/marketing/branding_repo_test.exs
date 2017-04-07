defmodule Blog.Marketing.BrandingRepoTest do
  use Blog.DataCase
  alias Blog.Marketing.Branding

  test "item must be unique" do
    Forge.saved_branding

    new_branding = Forge.branding
    changeset = Branding.changeset(new_branding)
    assert {:error, changeset} = Repo.insert(changeset)
    assert {:item, {"has already been taken", []}} in changeset.errors
  end
end
