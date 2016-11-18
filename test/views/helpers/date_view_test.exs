defmodule Blog.Helpers.DateViewTest do
  use ExUnit.Case
  alias Blog.Helpers.DateView

  test "returns the created on date as iso8601" do
    {:ok, dt} = Ecto.DateTime.cast(~N{2016-05-20 12:34:10})
    assert DateView.iso8601_date(dt) == "2016-05-20T12:34:10"
  end

  test "return the created on date as a readable string" do
    {:ok, dt} = Ecto.DateTime.cast(~N{2016-05-07 12:34:10})
    assert DateView.readable_date(dt) == "May 7, 2016"
  end
end
