defmodule Blog.Web.BrandingController do
  use Blog.Web, :controller
  alias Blog.{Marketing, Marketing.Branding}

  def index(conn, _) do
    branding = Marketing.list_branding()
    render(conn, "index.html", branding: branding)
  end

  def show(conn, %{"id" => id}) do
    branding = Marketing.get_branding(id)
    render(conn, "show.html", branding: branding)
  end

  def new(conn, _) do
    changeset = Branding.new_changeset()
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"branding" => params}) do
    case Marketing.create_branding(params) do
      {:ok, branding} ->
        conn
        |> put_flash(:info, "#{branding.item} created!")
        |> redirect(to: branding_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    changeset = Marketing.edit_changeset(id)
    render(conn, "edit.html", changeset: changeset)
  end

  def update(conn, %{"id" => id, "branding" => branding_params}) do 
    case Marketing.update(id, branding_params) do
      {:ok, branding} ->
        conn
        |> put_flash(:info, "Branding updated successfully.") 
        |> redirect(to: branding_path(conn, :show, branding.id))
      {:error, changeset} ->
        render(conn, "edit.html", changeset: changeset)
    end 
  end

  def delete(conn, %{"id" => id}) do 
    Marketing.delete(id)

    conn
    |> put_flash(:info, "Branding deleted successfully.") 
    |> redirect(to: branding_path(conn, :index))
  end
end
