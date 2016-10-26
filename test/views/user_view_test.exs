defmodule Blog.UserViewTest do
  use ExUnit.Case
  alias Blog.UserView

  test "returns page title for index page" do
    assert UserView.page_title(:index, %{}) == "Users"
  end

  test "return page title with the username" do
    user = %Blog.User{username: "jdoe"}
    assert UserView.page_title(:show, %{user: user}) == "User: jdoe"
  end
end
