defmodule Blog.Helpers.HtmlView do
  def to_html(nil), do: ""

  def to_html(markdown) do
    markdown
    |> Earmark.to_html
    |> Phoenix.HTML.raw
  end

  def title("") do
    "<title>Brian Gamble</title>"
    |> Phoenix.HTML.raw
  end

  def title(text) do
    "<title>#{concatenate(text)} | Brian Gamble</title>"
    |> Phoenix.HTML.raw
  end

  defp concatenate(str) do
    if String.length(str) > 40 do
      String.slice(str, 0, 40) <> "..."
    else
      str
    end
  end
end
