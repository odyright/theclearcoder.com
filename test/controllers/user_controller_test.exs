defmodule Blog.UserControllerTest do
  use Blog.ConnCase, async: true

  describe "with guest access" do
    test "login is required for all actions", %{conn: conn} do
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

  describe "with a logged in user" do
    setup :login_test_user

    test "'index' lists all users", %{conn: conn, user: user} do
      conn     = get conn, user_path(conn, :index)
      response = html_response(conn, 200) 
      
      assert response =~ "Listing Users"
      assert response =~ user.name
    end

    test "'show' renders a user if found", %{conn: conn, user: user} do
      conn     = get conn, user_path(conn, :show, user.id)
      response = html_response(conn, 200)
      
      assert response =~ "Showing User"
      assert response =~ user.name
    end

    test "'new' displays the new user form", %{conn: conn} do
      conn     = get conn, user_path(conn, :new)
      response = html_response(conn, 200)
      
      assert response =~ "New User"
      assert response =~ "form"
    end

    test "'create' redirects to the index page after creation", %{conn: conn} do
      conn = post conn, user_path(conn, :create, %{"user" => new_user()})

      assert html_response(conn, 302)
      assert conn.request_path == user_path(conn, :index) 
    end

    test "'create' saves the new user in the database", %{conn: conn} do
      user = new_user()
      post conn, user_path(conn, :create, %{"user" => user})
      saved_user = Repo.get_by(Blog.User, username: user["username"])

      assert user["name"] == saved_user.name
    end
  end

  defp login_test_user(context) do
    user = Forge.saved_user
    conn = assign(context[:conn], :current_user, user)
    [conn: conn, user: user]
  end

  defp new_user() do
    %{"name" => "John Doe", "password" => "password", "username" => "jdoe"}
  end
end
