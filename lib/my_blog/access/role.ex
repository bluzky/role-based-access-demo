defmodule MyBlog.Access.Role do
  use Ecto.Schema
  import Ecto.Changeset

  schema "roles" do
    field :code, :string
    field :filters, :map
    field :name, :string
    field :permissions, :map
    field :scope, :string

    timestamps()
  end

  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, [:name, :code, :permissions, :scope, :filters])
    |> validate_required([:name, :code, :permissions])
    |> unique_constraint(:code)
  end
end
