defmodule Blog.BrandingController do
  use Blog.Web, :controller
  alias Blog.Services.BrandingService

  def index(conn, _) do
    conn 
    |> render("index.html", branding: BrandingService.list_branding())
  end

  def show(conn, %{"id" => id}) do
    conn
    |> render("show.html", branding: BrandingService.get_by_id(id))
  end

  def new(conn, _) do
    conn
    |> render("new.html", changeset: BrandingService.new_changeset())
  end

  def create(conn, %{"branding" => params}) do
    case BrandingService.create(params) do
      {:ok, branding} ->
        conn
        |> put_flash(:info, "#{branding.item} created!")
        |> redirect(to: branding_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    conn
    |> render("edit.html", changeset: BrandingService.edit_changeset(id))
  end

  def update(conn, %{"id" => id, "branding" => branding_params}) do 
    case BrandingService.update(id, branding_params) do
      {:ok, branding} ->
        conn
        |> put_flash(:info, "Branding updated successfully.") 
        |> redirect(to: branding_path(conn, :show, branding.id))
      {:error, changeset} ->
        render(conn, "edit.html", changeset: changeset)
    end 
  end

  def delete(conn, %{"id" => id}) do 
    BrandingService.delete(id)

    conn
    |> put_flash(:info, "Branding deleted successfully.") 
    |> redirect(to: branding_path(conn, :index))
  end
end
