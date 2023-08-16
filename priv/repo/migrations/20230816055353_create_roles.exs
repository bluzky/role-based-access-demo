defmodule MyBlog.Repo.Migrations.CreateRoles do
  use Ecto.Migration

  def change do
    create table(:roles) do
      add :name, :string
      add :code, :string
      add :permissions, :map
      add :scope, :string
      add :filters, :map

      timestamps()
    end

    alter table(:users) do
      add :role_id, references(:roles, on_delete: :nilify_all)
    end
  end
end
