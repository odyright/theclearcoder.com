defmodule Blog.MediaTest do
  use Blog.DataCase, async: true
  alias Blog.Media

  test "returns an empty list with no podcasts" do
    assert Media.list_podcasts() == []
  end

  test "returns podcasts in order by date descending" do
    oldest = Forge.saved_podcast(inserted_at: Timepiece.days_ago(10))
    newest = Forge.saved_podcast(episode: 2)

    list = Media.list_podcasts()
    assert Enum.count(list) == 2
    assert [newest, oldest] == list
  end

  test "returns nil when requesting an unsaved episode" do
    assert Media.for_episode(1) == nil
  end

  test "returns the podcast that matches the episode" do
    podcast = Forge.saved_podcast
    assert Media.for_episode(podcast.episode) == podcast
  end

  test "returns the date of the newest podcast" do
    Forge.saved_podcast(inserted_at: Timepiece.days_ago(10))
    newest = Forge.saved_podcast(episode: 2)

    assert :eq == NaiveDateTime.compare(newest.inserted_at, Media.last_published_on()) 
  end

  test "returns nil for the date with no podcasts" do
    assert Media.last_published_on() == nil
  end
end
