defmodule Blog.Writing.Article do
  use Ecto.Schema
  import Ecto.Changeset
  alias Blog.Writing.Article

  schema "articles" do
    field :slug,    :string
    field :title,   :string
    field :teaser,  :string
    field :content, :string

    timestamps()
  end

  def changeset(article, params \\ %{}) do
    article
    |> cast(params, ~w(title teaser content))
    |> add_slug()
    |> validate_required([:title, :teaser, :content])
    |> unique_constraint(:slug)
  end

  @doc """
  Returns an article `Ecto.Changeset` with the given params.
  """
  def new_changeset(params \\ %{}) do
    Article.changeset(%Article{}, params)
  end

  defp add_slug(changeset) do
    if title = get_change(changeset, :title) || changeset.data.title do
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
