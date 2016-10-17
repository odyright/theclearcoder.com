defmodule Blog.Branding do
  use Blog.Web, :model

  schema "branding" do
    field :item, :string
    field :copy, :string
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(item copy), [])
    |> validate_required([:item, :copy])
    |> unique_constraint(:item)
  end

  @doc """
  Takes a list of branding content and returns the copy (text) of the requested item.  Returns nil
  if the item was not found.
  """
  @spec get_copy([Blog.Branding], String.t) :: String.t
  def get_copy(content, item) do
    content = Enum.find(content, fn(branding) -> branding.item == item end)
    content && content.copy
  end
end
