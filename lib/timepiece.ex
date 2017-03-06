defmodule Timepiece do
  @default_now &NaiveDateTime.utc_now/0
  @seconds 86_400

  def days_ago(num, now \\ @default_now) do
    add_or_remove_seconds(now.(), -(num * @seconds)) 
  end

  def days_from_now(num, now \\ @default_now) do
    add_or_remove_seconds(now.(), num * @seconds)
  end

  defp add_or_remove_seconds(ndt, seconds) do
    NaiveDateTime.add(ndt, seconds, :second) 
  end
end
