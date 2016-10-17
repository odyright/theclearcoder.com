defmodule Blog.PageView do
  use Blog.Web, :view
  alias Blog.Branding

  def page_title(:index, _assigns), do: "Welcome | "
  def page_title(:info, _assigns), do: "Info | "

  def html_copy(branding, item) do
    branding
    |> Branding.get_copy(item)
    |> to_html
  end
end
