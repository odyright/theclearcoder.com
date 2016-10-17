defmodule Blog.PageView do
  use Blog.Web, :view
  alias Blog.Branding

  def page_title(:index, _assigns), do: "Welcome | "
  def page_title(:info, _assigns), do: "Info | "

  def headline(branding) do
    branding
    |> Branding.get_copy("headline")
    |> to_html
  end

  def intro(branding) do
    branding
    |> Branding.get_copy("intro")
    |> to_html
  end

  def bio(branding) do
    branding
    |> Branding.get_copy("bio")
    |> to_html
  end
end
