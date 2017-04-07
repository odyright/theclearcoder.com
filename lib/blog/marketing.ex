defmodule Blog.Marketing do
  @moduledoc """
  Service that provides the ability to access branding information.
  """

  import Ecto.Query

  alias Blog.{Repo, Marketing.Branding}

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
  Returns a sorted, item ascending list of `Blog.Marketing.Branding`.
  """
  def list_branding() do
    Branding 
    |> order_by(asc: :item)
    |> Repo.all()
  end
  
  @doc """
  Returns a `Blog.Marketing.Branding` given an id.
  """
  def get_branding(num) do
    Repo.get(Branding, num)
  end

  @doc """
  Saves a new branding record to the database.  Returns {:ok, `Blog.Marketing.Branding`} if
  successful, otherwise {:error, `Ecto.Changeset`} that contains the errors. 
  """
  def create_branding(params) do
    Branding.new_changeset(params)
    |> Repo.insert()
  end

  @doc """
  Returns an `Ecto.Changeset` loaded with the `Blog.Marketing.Branding` specified by the id.  If
  new parameters are given, they will be contained in the changes.
  """
  def edit_changeset(id, new_params \\ %{}) do
    get_branding(id)
    |> Branding.changeset(new_params)
  end

  @doc """
  Updates a new branding record in the database.  Returns {:ok, `Blog.Marketing.Branding`} if
  successful, otherwise {:error, `Ecto.Changeset`} that contains the errors. 
  """
  def update_branding(branding, changes) do
    branding
    |> Branding.changeset(changes)
    |> Repo.update()
  end

  @doc """
  Delete a branding record in the database given the id.
  """
  def delete(id) do
    get_branding(id)
    |> Repo.delete()
  end
end
