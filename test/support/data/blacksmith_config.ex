defmodule Blacksmith.Config do
  alias Blog.{Repo, Article, User}

  def save(map = %User{}) do
    User.registration_changeset(map, %{password: "password"})
    |> Repo.insert!()
  end

  def save(map = %Article{}) do
    %Article{}
    |> Article.changeset(%{"title" => map.title, "teaser" => map.teaser, "content" => map.content})
    |> Repo.insert!()
  end

  def save(map) do
    Repo.insert!(map)
  end

  def save_all(list) do
    Enum.map(list, &save/1)
  end
end
