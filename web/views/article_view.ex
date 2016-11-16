defmodule Blog.ArticleView do
  use Blog.Web, :view

  @months  [ "January", "February", "March", "April", "May", "June",
             "July", "August", "September", "October", "November", "December" ]

  def page_title(:show, assigns) do
    assigns.article.title |> concatenate
  end
  def page_title(_action, _assigns), do: "Articles"

  defp concatenate(str) do
    if String.length(str) > 40 do
      String.slice(str, 0, 40) <> "..."
    else
      str
    end
  end

  def date_as_iso8601(%Blog.Article{inserted_at: dt}) do
    Ecto.DateTime.to_iso8601(dt)
  end

  def date_as_readable(%Blog.Article{inserted_at: dt}) do
    month = Enum.at(@months, dt.month - 1) 
    day   = dt.day
    year  = dt.year
    "#{month} #{day}, #{year}"
  end
end
