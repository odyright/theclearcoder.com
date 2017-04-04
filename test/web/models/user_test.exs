defmodule Blog.UserTest do
  use Blog.ModelCase, async: true
  alias Blog.User

  @valid_attrs %{name: "Joe Test", username: "jtest", password: "iamatester"}

  test "valid changeset with a hashed password" do
    changeset = User.registration_changeset(%User{}, @valid_attrs)
    assert changeset.valid?
    assert String.length(changeset.changes.password_hash) > 0
    assert changeset.changes.password_hash != changeset.changes.password
  end 

  test "name is required" do
    changeset = changeset_with_blank(:name)
    refute changeset.valid?
  end

  test "username is required" do
    changeset = changeset_with_blank(:username)
    refute changeset.valid?
  end

  test "username must be no greater than 20 characters" do
    changeset = changeset_with(%{username: "thisisareallylongname"})
    refute changeset.valid?
  end

  test "password must be at least 6 characters" do
    changeset = registration_changeset_with(%{password: "abcde"})
    refute changeset.valid?
  end

  defp changeset_with_blank(key) do
    changeset_with(%{key => " "})
  end

  defp changeset_with(attrs) do
    new_attrs = Map.merge(@valid_attrs, attrs)
    User.changeset(%User{}, new_attrs)
  end

  defp registration_changeset_with(attrs) do
    new_attrs = Map.merge(@valid_attrs, attrs)
    User.registration_changeset(%User{}, new_attrs)
  end
end
