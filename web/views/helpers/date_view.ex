defmodule Blog.Helpers.DateView do
  @months  [ "January", "February", "March", "April", "May", "June",
             "July", "August", "September", "October", "November", "December" ]

  def date_as_iso8601(dt) do
    Ecto.DateTime.to_iso8601(dt)
  end

  def date_as_readable(dt) do
    month = Enum.at(@months, dt.month - 1) 
    day   = dt.day
    year  = dt.year
    "#{month} #{day}, #{year}"
  end
end