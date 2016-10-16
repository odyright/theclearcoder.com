defmodule Blog.Repo.Migrations.CreateBranding do
  use Ecto.Migration

  def change do
    create table(:branding) do
      add :item, :string
      add :copy, :text
    end

    create unique_index(:branding, [:item])
  end
end
