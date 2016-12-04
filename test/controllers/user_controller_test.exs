defmodule Blog.UserControllerTest do
  use Blog.ConnCase, async: true

  describe "guest access" do
    test "requires login for all user actions", %{conn: conn} do
      Enum.each [
        get(conn, user_path(conn, :new)),
        get(conn, user_path(conn, :index)),
        get(conn, user_path(conn, :show, "1")),
        get(conn, user_path(conn, :create, %{}))
      ], fn conn ->
        assert html_response(conn, 302)
        assert conn.halted
      end
    end
  end

  describe "login access" do
    setup :login_test_user

    test "index/2 lists all users", %{conn: conn, user: user} do
      conn = get conn, user_path(conn, :index)
      assert html_response(conn, 200) =~ ~r/Listing Users/
      assert String.contains?(conn.resp_body, user.name)
    end

    test "show/2 renders the user if found", %{conn: conn, user: user} do
      conn = get conn, user_path(conn, :show, user.id)
      assert html_response(conn, 200) =~ ~r/Showing User/
      assert String.contains?(conn.resp_body, user.name)
    end

    test "new/2 displays the new user form", %{conn: conn} do
      conn = get conn, user_path(conn, :new)
      assert html_response(conn, 200) =~ ~r/New User/
      assert String.contains?(conn.resp_body, "form")
    end

    test "create/2 redirects to the index page", %{conn: conn} do
      conn = post conn, user_path(conn, :create, %{"user" => new_user()})
      assert html_response(conn, 302)
      assert conn.request_path == user_path(conn, :index) 
    end

    test "create/2 save a new user to the database", %{conn: conn} do
      user = new_user()
      post conn, user_path(conn, :create, %{"user" => user})
      saved_user = Repo.get_by(Blog.User, username: user["username"])
      assert user["name"] == saved_user.name
    end
  end

  defp login_test_user(context) do
    user = Fixtures.create(:user)
    conn = assign(context[:conn], :current_user, user)
    [conn: conn, user: user]
  end

  defp new_user() do
    %{"name" => "John Doe", "password" => "password", "username" => "jdoe"}
  end
end
