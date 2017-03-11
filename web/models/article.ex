defmodule Blog.Article do
  use Blog.Web, :model

  schema "articles" do
    field :slug,    :string
    field :title,   :string
    field :teaser,  :string
    field :content, :string

    timestamps()
  end

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, ~w(title teaser content))
    |> add_slug()
    |> validate_required([:title, :teaser, :content])
    |> unique_constraint(:slug)
  end

  defp add_slug(changeset) do
    if title = get_change(changeset, :title) do
      put_change(changeset, :slug, slugify(title)) 
    else
      changeset
    end
  end

  defp slugify(str) do
    str
    |> String.downcase()
    |> String.replace(~r/[^\w-]+/u, "-")
    |> String.replace_trailing("-", "")
  end
end
