defmodule Blog.PodcastControllerTest do
  use Blog.ConnCase, async: true

  test "should get index", %{conn: conn} do
    conn = get conn, podcast_path(conn, :index)
    assert html_response(conn, 200) =~ ~r/Podcast/
  end

  test "should get show", %{conn: conn} do
    podcast = Forge.saved_podcast 
    conn = get conn, podcast_path(conn, :show, podcast.episode)
    assert html_response(conn, 200) =~ ~r/#{podcast.title}/
  end

  test "should return 404 for an unknown episode", %{conn: conn} do
    Forge.saved_podcast(episode: 2)
    conn = get conn, podcast_path(conn, :show, 3)
    assert html_response(conn, 404)
  end
end
