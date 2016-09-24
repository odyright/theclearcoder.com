defmodule Blog.ArticleView do
  use Blog.Web, :view

  def content_as_html(%Blog.Article{content: content}) do
    Earmark.to_html(content)
    |> raw 
  end
end
