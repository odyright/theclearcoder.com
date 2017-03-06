defmodule Timepiece do
  @moduledoc """
  Provides the ability to go backwards and forwards in time from the current date.
  """

  @default_now &NaiveDateTime.utc_now/0
  @seconds 86_400

  @doc """
  Calculate and returns a `NaiveDateTime` given a number of days in past.
  """
  def days_ago(num, now \\ @default_now) do
    add_or_remove_seconds(now.(), -(num * @seconds)) 
  end

  @doc """
  Calculate and returns a `NaiveDateTime` given a number of days in the future.
  """
  def days_from_now(num, now \\ @default_now) do
    add_or_remove_seconds(now.(), num * @seconds)
  end

  defp add_or_remove_seconds(ndt, seconds) do
    NaiveDateTime.add(ndt, seconds, :second) 
  end
end
