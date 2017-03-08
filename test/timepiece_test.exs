defmodule TimepieceTest do
  use ExUnit.Case

  test "5 days ago" do
    expected = ~N[2017-03-01 12:27:10]
    actual   = Timepiece.days_ago(5, &now/0)
    assert :eq == NaiveDateTime.compare(expected, actual)
  end

  test "10 days from now" do
    expected = ~N[2017-03-16 12:27:10]
    actual   = Timepiece.days_from_now(10, &now/0)
    assert :eq == NaiveDateTime.compare(expected, actual)
  end

  test "determines if a datetime is less than a minute old" do
    assert Timepiece.last_minute?(~N[2017-03-06 12:26:24], &now/0)
    refute Timepiece.last_minute?(~N[2017-03-06 12:25:24], &now/0)
  end

  defp now(), do: ~N[2017-03-06 12:27:10]
end
