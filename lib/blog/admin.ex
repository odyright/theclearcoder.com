defmodule Blog.Admin do
  @moduledoc """
  Service that provides the ability to access users..
  """

  import Ecto.Query
  alias Blog.{Repo, Admin.User}

  @doc """
  Returns a sorted, name ascending list of `Blog.Admin.User`.
  """
  def list_users() do
    User
    |> order_by(:name)
    |> Repo.all()
  end

  @doc """
  Returns a `Blog.Admin.User` given an id.
  """
  def get_user(id) do
    Repo.get(User, id)
  end

  @doc """
  Saves a new user record to the database.  Returns {:ok, `Blog.Admin.User`} if
  successful, otherwise an {:error, `Ecto.Changeset`} that contains the errors.
  """
  def create_user(params) do
    User.registration_changeset(%User{}, params)
    |> Repo.insert()
  end
end
