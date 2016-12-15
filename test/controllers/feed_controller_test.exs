defmodule Blog.FeedControllerTest do
  use Blog.ConnCase, async: true

  test "'podcast' renders the xml feed for the CLD podcast", %{conn: conn} do
    conn = get conn, feed_path(conn, :podcast)
    assert response_content_type(conn, :xml) =~ "application/rss+xml; charset=utf-8"
    assert response(conn, 200) =~ ~r/rss/
  end
end
