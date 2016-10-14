defmodule Blog.Repo.Migrations.CreateArticle do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :slug,    :string
      add :title,   :string
      add :teaser,  :text
      add :content, :text

      timestamps
    end

    create unique_index(:articles, [:slug])
  end
end
