defmodule Blog.ViewHelpers do
  def to_html(nil), do: ""

  def to_html(markdown) do
    markdown
    |> Earmark.to_html
    |> Phoenix.HTML.raw
  end
end
