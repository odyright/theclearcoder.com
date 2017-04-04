defmodule Blog.PodcastTest do
  use Blog.DataCase, async: true

  alias Blog.Podcast

  @valid_attrs %{description: "some content", episode: 42, file_size_mbytes: 42, file_url: "some content", notes: "some content", run_time_minutes: 42, title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Podcast.changeset(%Podcast{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Podcast.changeset(%Podcast{}, @invalid_attrs)
    refute changeset.valid?
  end
end
