defmodule Blog.Web.Helpers.DateView do
  @months  [ "January", "February", "March", "April", "May", "June",
             "July", "August", "September", "October", "November", "December" ]

  def iso8601_date(dt = %NaiveDateTime{}) do
    NaiveDateTime.to_iso8601(dt)
  end

  def iso8601_date(dt = %Ecto.DateTime{}) do
    Ecto.DateTime.to_iso8601(dt)
  end

  def readable_date(dt) do
    month = Enum.at(@months, dt.month - 1) 
    day   = dt.day
    year  = dt.year
    "#{month} #{day}, #{year}"
  end
end
