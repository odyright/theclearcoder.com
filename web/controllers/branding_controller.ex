defmodule Blog.BrandingController do
  use Blog.Web, :controller
  alias Blog.Branding

  def index(conn, _) do
    query = Branding |> order_by(desc: :item)
    branding = Repo.all(query)
    render conn, "index.html", branding: branding
  end

  def show(conn, %{"id" => id}) do
    content = Repo.get!(Branding, id)
    render conn, "show.html", content: content
  end
end
