defmodule Blacksmith.Config do
  alias Blog.{Repo, Admin.User}

  def save(schema = %User{}) do
    User.registration_changeset(schema, %{password: "password"})
    |> Repo.insert!()
  end

  def save(schema) do
    schema
    |> schema.__struct__.changeset()
    |> Repo.insert!()
  end

  def save_all(list) do
    Enum.map(list, &save/1)
  end
end
