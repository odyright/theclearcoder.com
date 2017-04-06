defmodule Blog.Marketing.Branding do
  use Ecto.Schema
  import Ecto.Changeset

  schema "branding" do
    field :item, :string
    field :copy, :string
  end

  def changeset(branding, params \\ %{}) do
    branding
    |> cast(params, ~w(item copy))
    |> validate_required([:item, :copy])
    |> unique_constraint(:item)
  end
end
