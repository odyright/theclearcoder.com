defmodule Blog.Services.BrandingService do
  @moduledoc """
  Service that provides the ability to access branding information.
  """

  import Ecto.Query

  alias Blog.{Repo, Branding}

  @doc """
  Returns all of the saved branding as a map with the key being the name
  of the branding and value containing the copy; otherwise it returns an
  empty map.
  """
  def get_copy() do
    branding = Repo.all(Branding)
    Enum.reduce(branding, %{}, fn(b, acc) -> 
      Map.put(acc, String.to_atom(b.item), b.copy)
    end)
  end

  @doc """
  Returns a sorted, item ascending list of `Blog.Branding`.
  """
  def list_branding() do
    Branding 
    |> order_by(asc: :item)
    |> Repo.all()
  end
  
  @doc """
  Returns a `Blog.Branding` given an id.
  """
  def get_by_id(num) do
    Repo.get(Branding, num)
  end

  @doc """
  Returns a branding `Ecto.Changeset` given the params.
  """
  def new_changeset(params \\ %{}) do
    Branding.changeset(%Branding{}, params)
  end

  @doc """
  Saves a new branding record to the database.  Returns {:ok, `Blog.Branding`} if
  successful, otherwise {:error, `Ecto.Changeset`} that contains the errors. 
  """
  def create(params) do
    new_changeset(params)
    |> Repo.insert()
  end

  @doc """
  Returns an `Ecto.Changeset` loaded with the `Blog.Branding` specified by the id.  If
  new parameters are given, they will be contained in the changes.
  """
  def edit_changeset(id, new_params \\ %{}) do
    get_by_id(id)
    |> Branding.changeset(new_params)
  end

  @doc """
  Updates a new branding record in the database.  Returns {:ok, `Blog.Branding`} if
  successful, otherwise {:error, `Ecto.Changeset`} that contains the errors. 
  """
  def update(id, params) do
    edit_changeset(id, params)
    |> Repo.update()
  end

  @doc """
  Delete a branding record in the database given the id.
  """
  def delete(id) do
    get_by_id(id)
    |> Repo.delete()
  end
end
