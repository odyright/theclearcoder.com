defmodule Blog.BrandingController do
  use Blog.Web, :controller

  alias Blog.Branding
  alias Blog.Services.BrandingService

  def index(conn, _) do
    render conn, "index.html", branding: BrandingService.list_branding()
  end

  def show(conn, %{"id" => id}) do
    render conn, "show.html", branding: BrandingService.get_by_id(id)
  end

  def new(conn, _) do
    changeset = Branding.changeset(%Branding{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"branding" => branding_params}) do
    changeset = Branding.changeset(%Branding{}, branding_params)
    case Repo.insert(changeset) do
      {:ok, branding} ->
        conn
        |> put_flash(:info, "#{branding.item} created!")
        |> redirect(to: branding_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    branding = BrandingService.get_by_id(id)
    changeset = Branding.changeset(branding)
    render conn, "edit.html", branding: branding, changeset: changeset
  end

  def update(conn, %{"id" => id, "branding" => branding_params}) do 
    branding = BrandingService.get_by_id(id)
    changeset = Branding.changeset(branding, branding_params)
    case Repo.update(changeset) do 
      {:ok, branding} ->
        conn
        |> put_flash(:info, "Branding updated successfully.") 
        |> redirect(to: branding_path(conn, :show, branding.id))
      {:error, changeset} ->
        render(conn, "edit.html", branding: branding, changeset: changeset)
    end 
  end

  def delete(conn, %{"id" => id}) do 
    branding = BrandingService.get_by_id(id)
    Repo.delete!(branding)

    conn
    |> put_flash(:info, "Branding deleted successfully.") 
    |> redirect(to: branding_path(conn, :index))
  end
end
