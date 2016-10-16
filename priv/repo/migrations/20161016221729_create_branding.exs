defmodule Blog.Repo.Migrations.CreateBranding do
  use Ecto.Migration

  def change do
    create table(:branding) do
      add :item, :string
      add :copy, :text
    end
  end
end
