defmodule Blog.Services.BrandingService do
  @moduledoc """
  Service that provides the ability to access branding information.
  """

  alias Blog.Repo
  alias Blog.Branding

  @doc """
  Returns all of the saved branding as a map with the key being the name
  of the branding and value containing the copy; otherwise it returns an
  empty map.
  """
  def get_copy() do
    branding = Repo.all(Branding)
    Enum.reduce(branding, %{}, fn(b, acc) -> 
      Map.put(acc, b.item, b.copy)
    end)
  end
end