defmodule Blog.Services.UserServiceTest do
  use Blog.ModelCase 
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
end
