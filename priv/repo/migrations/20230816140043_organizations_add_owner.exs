defmodule MyBlog.Repo.Migrations.OrganizationsAddOwner do
  use Ecto.Migration

  def change do
    alter table(:organizations) do
      add :owner_id, references(:users, on_delete: :nilify_all)
    end
  end
end
