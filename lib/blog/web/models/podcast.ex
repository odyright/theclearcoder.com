defmodule Blog.Podcast do
  use Blog.Web, :model

  schema "podcasts" do
    field :episode, :integer
    field :title, :string
    field :description, :string
    field :notes, :string
    field :file_url, :string
    field :file_size_mbytes, :integer
    field :run_time_minutes, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:episode, :title, :description, :notes, :file_url, :file_size_mbytes, :run_time_minutes])
    |> validate_required([:episode, :title, :description, :file_url, :file_size_mbytes, :run_time_minutes])
    |> unique_constraint(:episode)
  end
end
