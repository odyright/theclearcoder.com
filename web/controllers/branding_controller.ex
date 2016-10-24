defmodule Blog.BrandingController do
  use Blog.Web, :controller
  alias Blog.Branding

  def index(conn, _) do
    query = Branding |> order_by(desc: :item)
    branding = Repo.all(query)
    render conn, "index.html", branding: branding
  end

  def show(conn, %{"id" => id}) do
    branding = Repo.get!(Branding, id)
    render conn, "show.html", branding: branding
  end

  def edit(conn, %{"id" => id}) do
    branding = Repo.get!(Branding, id)
    changeset = Branding.changeset(branding)
    render conn, "edit.html", branding: branding, changeset: changeset
  end

  def update(conn, %{"id" => id, "branding" => branding_params}) do 
    branding = Repo.get_by!(Branding, id: id)
    changeset = Branding.changeset(branding, branding_params)
    case Repo.update(changeset) do 
      {:ok, article} ->
        conn
        |> put_flash(:info, "Branding updated successfully.") 
        |> redirect(to: branding_path(conn, :show, branding.id))
      {:error, changeset} ->
        render(conn, "edit.html", branding: branding, changeset: changeset)
    end 
  end
end
