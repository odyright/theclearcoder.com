defmodule Blog.ArticleView do
  use Blog.Web, :view

  @months  [ "January", "February", "March", "April", "May", "June",
             "July", "August", "September", "October", "November", "December" ]

  def page_title(:index, _assigns), do: "Articles | "
  def page_title(:show, assigns) do
    assigns.article.title <> " | "
  end

  def content_as_html(%Blog.Article{content: content}) do
    Earmark.to_html(content)
    |> raw 
  end

  def md_to_html(text) do
    Earmark.to_html(text)
    |> raw 
  end

  def date_as_iso8601(%Blog.Article{created_on: dt}) do
    NaiveDateTime.to_iso8601(dt)
  end

  def date_as_readable(%Blog.Article{created_on: dt}) do
    month = Enum.at(@months, dt.month - 1) 
    day   = dt.day
    year  = dt.year
    "#{month} #{day}, #{year}"
  end
end
