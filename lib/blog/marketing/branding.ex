defmodule Blog.Marketing.Branding do
  use Ecto.Schema
  import Ecto.Changeset
  alias Blog.Marketing.Branding

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

  @doc """
  Returns a branding `Ecto.Changeset` given the params.
  """
  def new_changeset(params \\ %{}) do
    Branding.changeset(%Branding{}, params)
  end
end
