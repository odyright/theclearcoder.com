defmodule Blog.Repo do
  @moduledoc """
  In-memory repository.
  """

  def all(Blog.Article) do
    [%Blog.Article{id: "1", slug: "new-beginnings"}] 
  end

  def all(_module), do: []

  def get_by(module, params) do Enum.find all(module), fn map ->
    Enum.all?(params, fn {key, val} -> Map.get(map, key) == val end) end
  end
end
