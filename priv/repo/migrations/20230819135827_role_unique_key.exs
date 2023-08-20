defmodule MyBlog.Repo.Migrations.RoleUniqueKey do
  use Ecto.Migration

  def change do
    create unique_index(:roles, [:code])
  end
end
