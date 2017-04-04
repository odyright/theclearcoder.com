defmodule Blog.FeedControllerTest do
  use Blog.ConnCase, async: true

  test "'podcast' renders the xml feed for the CLD podcast", %{conn: conn} do
    episode_1 = Forge.saved_podcast(inserted_at: Timepiece.days_ago(2))
    episode_2 = Forge.saved_podcast(episode: 2)
    conn      = get conn, feed_path(conn, :podcast)
    response  = response(conn, 200) 

    assert response_content_type(conn, :xml) =~ "application/rss+xml; charset=utf-8"
    assert response =~ "rss"
    assert response =~ "<lastBuildDate>#{NaiveDateTime.to_iso8601(episode_2.inserted_at)}</lastBuildDate>"
    assert response =~ episode_1.title
    assert response =~ episode_2.title
  end
end
