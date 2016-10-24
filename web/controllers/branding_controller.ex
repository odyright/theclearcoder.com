defmodule Blog.BrandingController do
  use Blog.Web, :controller
  alias Blog.Branding

  def index(conn, _) do
    query = Branding |> order_by(desc: :item)
    branding = Repo.all(query)
    render conn, "index.html", branding: branding
  end
end
