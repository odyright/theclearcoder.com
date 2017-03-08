defmodule Blog.SessionControllerTest do
  use Blog.ConnCase

  test "should display the login form with new", %{conn: conn} do
    conn = get conn, session_path(conn, :new)
    response = html_response(conn, 200)

    assert response =~ "Sign in"
    assert response =~ "form"
  end

  test "successful login redirects and sets a flash message", %{conn: conn} do
    user = Forge.saved_user
    user_params = %{"username" => user.username, "password" => user.password}
    conn = post conn, session_path(conn, :create, %{"session" => user_params})
    
    assert redirected_to(conn, 302) =~ page_path(conn, :index)
    assert get_flash(conn, :info) == "Welcome back!"
  end

  test "failed login displays an error message", %{conn: conn} do
    user = Forge.saved_user
    user_params = %{"username" => user.username, "password" => "invalid"}
    conn = post conn, session_path(conn, :create, %{"session" => user_params})

    assert html_response(conn, 200) =~ "Invalid username/password combination"
  end

  describe "with a logged in user" do
    setup :login_test_user

    test "user logout redirects to the index page", %{conn: conn} do
      conn = delete conn, session_path(conn, :delete, 1)
      assert redirected_to(conn, 302) =~ page_path(conn, :index)

      conn = get conn, page_path(conn, :index)
      refute html_response(conn, 200) =~ "Sign out"
    end
  end
end
