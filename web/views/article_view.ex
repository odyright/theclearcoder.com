defmodule Blog.ArticleView do
  use Blog.Web, :view
  import Blog.Helpers.DateView, only: [date_as_iso8601: 1, date_as_readable: 1]

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
end
