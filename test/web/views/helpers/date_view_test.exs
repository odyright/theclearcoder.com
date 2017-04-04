defmodule Blog.Helpers.DateViewTest do
  use ExUnit.Case, async: true
  alias Blog.Helpers.DateView

  test "returns a NaiveDateTime as iso8601" do
    assert DateView.iso8601_date(~N{2016-05-20 12:34:10}) == "2016-05-20T12:34:10"
  end

  test "returns an Ecto.DateTime as iso8601" do
    {:ok, dt} = Ecto.DateTime.cast(~N{2016-05-20 12:34:10})
    assert DateView.iso8601_date(dt) == "2016-05-20T12:34:10"
  end

  test "returns an Ecto.DateTime as a readable string" do
    {:ok, dt} = Ecto.DateTime.cast(~N{2016-05-07 12:34:10})
    assert DateView.readable_date(dt) == "May 7, 2016"
  end
end
