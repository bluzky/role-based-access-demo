defmodule MyBlog.Org.Organization do
  use Ecto.Schema
  import Ecto.Changeset

  schema "organizations" do
    field :address, :string
    field :contact_email, :string
    field :logo, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(organization, attrs) do
    organization
    |> cast(attrs, [:name, :logo, :contact_email, :address])
    |> validate_required([:name])
  end
end
