defmodule Blog.PageControllerTest do
  use Blog.ConnCase, async: true

  test "should get index", %{conn: conn} do
    conn = get conn, page_path(conn, :index)
    assert html_response(conn, 200) =~ ~r/Welcome/
  end

  test "should get info", %{conn: conn} do
    conn = get conn, page_path(conn, :info)
    assert html_response(conn, 200) =~ ~r/Info/
  end

  test "should get projects", %{conn: conn} do
    conn = get conn, page_path(conn, :projects)
    assert html_response(conn, 200) =~ ~r/Projects/
  end

  test "should get keybase", %{conn: conn} do
    conn = get conn, page_path(conn, :keybase)
    assert text_response(conn, 200) =~ ~r/keybase.io/
  end

  test "should get let's encrypt", %{conn: conn} do
    conn = get conn, page_path(conn, :letsencrypt, "foo")
    assert text_response(conn, 200) 
  end
end
