defmodule Blog.Repo.Migrations.CreatePodcast do
  use Ecto.Migration

  def change do
    create table(:podcasts) do
      add :episode, :integer
      add :title, :string
      add :description, :string
      add :notes, :text
      add :file_url, :string
      add :file_size_mbytes, :integer
      add :run_time_minutes, :integer

      timestamps()
    end
    create unique_index(:podcasts, [:episode])
  end
end
