defmodule Blog.BrandingView do
  use Blog.Web, :view

  def page_title(:index, _) do
    "Branding | "
  end
end
