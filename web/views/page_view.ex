defmodule Blog.PageView do
  use Blog.Web, :view

  def page_title(:index, _assigns), do: "Welcome | "
  def page_title(:info, _assigns), do: "Info | "

  def html_copy(branding, item) do
    branding
    |> get_copy(item)
    |> to_html
  end

  def get_copy(content, item) do
    content = Enum.find(content, fn(branding) -> branding.item == item end)
    content && content.copy
  end
end
