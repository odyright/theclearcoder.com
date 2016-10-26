defmodule Blog.BrandingView do
  use Blog.Web, :view

  def page_title(:index, _assigns), do: "Branding"
  def page_title(_action, assigns) do
    "Branding: #{assigns.branding.item}"
  end
end
