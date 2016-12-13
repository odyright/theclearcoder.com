defmodule Blog.BrandingView do
  use Blog.Web, :view

  def page_title(:index, _), do: "Branding"
  def page_title(_action, assigns) do
    if Map.has_key?(assigns, :branding) do
      "Branding: #{assigns.branding.item}"
    else
      page_title(:index, assigns)
    end
  end
end
