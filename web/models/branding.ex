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
end
