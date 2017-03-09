defmodule Blog.Services.UserService do
  @moduledoc """
  Service that provides the ability to access users..
  """

  import Ecto.Query
  alias Blog.{Repo, User}

  @doc """
  Returns a sorted, name ascending list of `Blog.User`.
  """
  def list_users() do
    User
    |> order_by(:name)
    |> Repo.all()
  end
end
