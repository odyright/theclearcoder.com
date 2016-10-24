defmodule Blog.BrandingView do
  use Blog.Web, :view

  def page_title(:show, assigns) do
    "Branding: #{assigns.content.item} | "
  end

  def page_title(_action, _assigns), do: "Branding | "
end
