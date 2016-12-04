defmodule Blog.UserViewTest do
  use ExUnit.Case
  alias Blog.UserView

  test "return a generic title with no assigned user" do
    assert UserView.page_title(:foo, %{}) == "Users"
  end

  test "return page title with the username" do
    user = %Blog.User{username: "jdoe"}
    assert UserView.page_title(:show, %{user: user}) == "User: jdoe"
  end
end
