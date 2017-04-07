defmodule Blog.MarketingTest do
  use Blog.DataCase, async: true

  alias Blog.{Marketing, Marketing.Branding}

  test "returns an empty map with no branding" do
    assert Marketing.get_copy() == %{}
  end

  test "returns the branding content as a map" do
    foo = Forge.saved_branding(item: "foo")
    bar = Forge.saved_branding(item: "bar")
    assert Marketing.get_copy() == %{
      :foo => foo.copy,
      :bar => bar.copy
    }
  end

  test "returns an empty list with no branding" do
    assert Marketing.list_branding() == []
  end

  test "returns a branding list sorted by item" do
    foo = Forge.saved_branding(item: "foo")
    bar = Forge.saved_branding(item: "bar")
    assert Marketing.list_branding() == [ bar, foo ]
  end

  test "returns nil when trying to retrieve a brand that doesn't exist" do
    assert Marketing.get_branding(1) == nil
  end

  test "return the branding record by the id" do
    branding = Forge.saved_branding
    assert Marketing.get_branding(branding.id) == branding
  end

  test "creates a new record in the database" do
    params = %{item: "foo", copy: "bar"}
    {:ok, branding} = Marketing.create_branding(params)
    assert Repo.get_by(Branding, item: "foo") == branding
  end

  test "returns an error changeset when create fails" do
    params = %{item: "foo", copy: " "}
    {:error, changeset} = Marketing.create_branding(params)
    refute changeset.valid?
    assert Enum.count(changeset.errors) == 1
    assert Repo.get_by(Branding, item: "foo") == nil
  end

  test "returns a edit branding changeset" do
    branding  = Forge.saved_branding
    changeset = Marketing.edit_changeset(branding.id)
    assert changeset.data == branding
  end

  test "returns an edit branding changeset with param changes" do
    branding  = Forge.saved_branding
    new_copy  = %{copy: "bar baz"}
    changeset = Marketing.edit_changeset(branding.id, new_copy)
    assert changeset.data == branding
    assert changeset.changes == new_copy
  end

  test "updates an existing record in the database" do
    branding = Forge.saved_branding
    params   = %{copy: "some new copy"}
    {:ok, updated_branding} = Marketing.update_branding(branding, params)
    assert updated_branding.item == branding.item
    assert updated_branding.copy == params[:copy]
  end

  test "returns an error changes when update fails" do
    branding = Forge.saved_branding
    params   = %{copy: " "}
    {:error, changeset} = Marketing.update_branding(branding, params)
    refute changeset.valid?
    assert Enum.count(changeset.errors) == 1
    assert Repo.get(Branding, branding.id) == branding
  end

  test "deletes an existing record in the database" do
    branding = Forge.saved_branding
    Marketing.delete_branding(branding)
    assert Repo.get(Branding, branding.id) == nil
  end
end
