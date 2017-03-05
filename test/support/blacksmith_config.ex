defmodule Blacksmith.Config do
  alias Blog.Repo

  def save(map = %Blog.User{}) do
    Blog.User.registration_changeset(map, %{password: "password"})
    |> Repo.insert!()
  end

  def save(map) do
    Repo.insert!(map)
  end

  def save_all(list) do
    Enum.map(list, &save/1)
  end
end
