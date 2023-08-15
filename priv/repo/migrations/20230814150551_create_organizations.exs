defmodule MyBlog.Repo.Migrations.CreateOrganizations do
  use Ecto.Migration

  def change do
    create table(:organizations) do
      add :name, :string
      add :logo, :string
      add :contact_email, :string
      add :address, :string

      timestamps()
    end
  end
end
