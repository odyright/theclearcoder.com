defmodule Blog.PageControllerTest do
  use Blog.ConnCase, async: true

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "<title>Welcome | Brian Gamble</title>"
  end

  test "GET /info", %{conn: conn} do
    conn = get conn, "/info"
    assert html_response(conn, 200) =~ "<title>Info | Brian Gamble</title>"
  end

  test "GET /projects", %{conn: conn} do
    conn = get conn, "/projects"
    assert html_response(conn, 200) =~ "The Coding Show"
  end

  test "when let's encrypt is off it returns nothing", %{conn: conn} do
    conn = get conn, "/.well-known/acme-challenge/aabbccddeeff"
    assert text_response(conn, 200) == ""
  end

  test "when let's encrypt is on it returns a response", %{conn: conn} do
    conn = assign(conn, :letsencrypt, "ON")
    conn = assign(conn, :letsencrypt_response, "bar")
    conn = get conn, "/.well-known/acme-challenge/aabbccddeeff"
    assert text_response(conn, 200) == "aabbccddeeffbar"
  end
end
