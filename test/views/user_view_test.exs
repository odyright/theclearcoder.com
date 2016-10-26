defmodule Blog.UserViewTest do
  use ExUnit.Case
  alias Blog.UserView

  test "returns page title for user views" do
    assert UserView.page_title(:index, %{}) == "Users | "
  end
end
