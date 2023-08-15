defmodule MyBlog.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :text
      add :image, :text
      add :content, :text
      add :status, :text
      add :author_id, references(:users, on_delete: :nilify_all)
      add :organization_id, references(:organizations, on_delete: :delete_all)

      timestamps()
    end

    create index(:posts, [:author_id])
    create index(:posts, [:organization_id])
  end
end
