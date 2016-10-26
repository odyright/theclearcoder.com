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
    attrs = Dict.merge(@valid_attrs, %{name: " "})
    changeset = User.changeset(%User{}, attrs)
    refute changeset.valid?
  end

  test "username is required" do
    attrs = Dict.merge(@valid_attrs, %{username: " "})
    changeset = User.changeset(%User{}, attrs)
    refute changeset.valid?
  end

  test "username must be no greater than 20 characters" do
    attrs = Dict.merge(@valid_attrs, %{username: "thisisareallylongname"})
    changeset = User.changeset(%User{}, attrs)
    refute changeset.valid?
  end

  test "password must be at least 6 characters" do
    attrs = Dict.merge(@valid_attrs, %{password: "abcde"})
    changeset = User.registration_changeset(%User{}, attrs)
    refute changeset.valid?
  end
end
