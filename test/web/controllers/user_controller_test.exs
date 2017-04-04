defmodule Blog.Web.UserControllerTest do
  use Blog.Web.ConnCase, async: true

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

    test "should display a list of all the users", %{conn: conn, user: user} do
      conn     = get conn, user_path(conn, :index)
      response = html_response(conn, 200) 
      
      assert response =~ "Listing Users"
      assert response =~ print_name(user)
    end

    test "should display the user details", %{conn: conn, user: user} do
      conn     = get conn, user_path(conn, :show, user.id)
      response = html_response(conn, 200)
      
      assert response =~ "Showing User"
      assert response =~ print_name(user)
    end

    test "should display the new user form", %{conn: conn} do
      conn     = get conn, user_path(conn, :new)
      response = html_response(conn, 200)
      
      assert response =~ "New User"
      assert response =~ "form"
    end

    test "successful create redirects and sets a flash message", %{conn: conn} do
      user_params = new_user()
      conn = post conn, user_path(conn, :create, %{"user" => user_params})

      assert redirected_to(conn, 302) =~ user_path(conn, :index)
      assert get_flash(conn, :info) == "#{user_params["name"]} created!"
    end

    test "failed create displays an error message", %{conn: conn} do
      params_with_blank_username = Map.put(new_user(), "username", " ")
      conn = post conn, user_path(conn, :create, %{"user" => params_with_blank_username})

      assert html_response(conn, 200) =~ "check the errors below"
    end
  end

  defp new_user() do
    %{"name" => "John Doe", "password" => "password", "username" => "jdoe"}
  end

  # Since I'm using Faker and Earkmark, handle the case when a user's name contains
  # an apostrophe.
  defp print_name(user) do
    String.replace(user.name, "'", "&#39;")
  end
end
