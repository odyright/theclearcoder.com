defmodule Blog.PageControllerTest do
  use Blog.ConnCase, async: true

  test "'index' renders the homepage", %{conn: conn} do
    conn = get conn, page_path(conn, :index)
    assert html_response(conn, 200) =~ ~r/Welcome/
  end

  test "'info' renders the info page", %{conn: conn} do
    conn = get conn, page_path(conn, :info)
    assert html_response(conn, 200) =~ ~r/Info/
  end

  test "'projects' renders the project page", %{conn: conn} do
    conn = get conn, page_path(conn, :projects)
    assert html_response(conn, 200) =~ ~r/Projects/
  end

  test "'keybase' renders the keybase info page", %{conn: conn} do
    conn = get conn, page_path(conn, :keybase)
    assert text_response(conn, 200) =~ ~r/keybase.io/
  end

  describe "let's encrypt" do
    test "does nothing when off", %{conn: conn} do
      conn = get conn, page_path(conn, :letsencrypt, "aabbccddeeff")
      assert text_response(conn, 200) == ""
    end

    test "returns a response when on", %{conn: conn} do
      conn = assign(conn, :letsencrypt, "ON")
      conn = assign(conn, :letsencrypt_response, "bar")
      conn = get conn, page_path(conn, :letsencrypt, "aabbccddeeff")
      assert text_response(conn, 200) == "aabbccddeeffbar"
    end
  end
end
