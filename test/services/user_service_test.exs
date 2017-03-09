defmodule Blog.Services.UserServiceTest do
  use Blog.ModelCase 
  alias Blog.User
  alias Blog.Services.UserService

  test "returns an empty list with no users" do
    assert UserService.list_users() == []
  end

  test "returns a sorted list of users" do
    Forge.saved_user(name: "Brady")
    Forge.saved_user(name: "Henry")
    Forge.saved_user(name: "Bradley")
    users = UserService.list_users()

    assert Enum.count(users) == 3
    assert Enum.at(users, 0).name == "Bradley"
    assert Enum.at(users, 1).name == "Brady"
    assert Enum.at(users, 2).name == "Henry"
  end

  test "return nil with an unknown users" do
    assert UserService.get_by_id(99) == nil
  end

  test "returns the requested user" do
    expected_user = Forge.saved_user
    user = UserService.get_by_id(expected_user.id)
    assert expected_user.name == user.name
  end

  test "generates a new user changeset" do
    changeset = UserService.new_changeset()
    assert changeset.data == %User{}
    assert changeset.changes == %{}
  end
end
