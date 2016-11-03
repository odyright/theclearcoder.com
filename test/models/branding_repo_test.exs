defmodule Blog.BrandingRepoTest do
  use Blog.ModelCase
  alias Blog.Branding

  test "item must be unique" do
    Fixtures.create(:branding)

    new_branding = Fixtures.build(:branding)
    changeset = Branding.changeset(new_branding)
    assert {:error, changeset} = Repo.insert(changeset)
    assert {:item, {"has already been taken", []}} in changeset.errors
  end
end
