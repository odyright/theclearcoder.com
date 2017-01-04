defmodule Blog.Article do
  use Blog.Web, :model

  schema "articles" do
    field :slug,    :string
    field :title,   :string
    field :teaser,  :string
    field :content, :string

    timestamps
  end

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, ~w(slug title teaser content inserted_at))
    |> validate_required([:slug, :title, :teaser, :content, :inserted_at])
    |> unique_constraint(:slug)
  end
end
