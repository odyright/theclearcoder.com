defmodule Timepiece do
  @moduledoc """
  Provides the ability to go backwards and forwards in time from the current date.
  """

  @default_now &__MODULE__.now/0
  @day 86_400
  @minute 60

  @doc """
  Returns the current naive datetime in UTC.
  """
  def now(), do: NaiveDateTime.utc_now()

  @doc """
  Calculate and returns a `NaiveDateTime` given a number of days in past.
  """
  def days_ago(num, now \\ @default_now) do
    add_or_remove_seconds(now.(), -(num * @day)) 
  end

  @doc """
  Calculate and returns a `NaiveDateTime` given a number of days in the future.
  """
  def days_from_now(num, now \\ @default_now) do
    add_or_remove_seconds(now.(), num * @day)
  end

  @doc """
  Return `true` if the given `NaiveDateTime` occurred within the past minute, 
  otherwise `false`.
  """
  def last_minute?(ndt, now \\ @default_now) do
    NaiveDateTime.diff(now.(), ndt) <= @minute
  end

  defp add_or_remove_seconds(ndt, seconds) do
    NaiveDateTime.add(ndt, seconds, :second) 
  end
end
