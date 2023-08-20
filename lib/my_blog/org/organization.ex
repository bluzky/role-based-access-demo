defmodule MyBlog.Org.Organization do
  use Ecto.Schema
  use MyBlog.Access.Multitenancy, column: :id
  import Ecto.Changeset

  schema "organizations" do
    field :address, :string
    field :contact_email, :string
    field :logo, :string
    field :name, :string
    belongs_to :owner, MyBlog.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(organization, attrs) do
    organization
    |> cast(attrs, [:name, :logo, :contact_email, :address, :owner_id])
    |> validate_required([:name, :owner_id])
  end
end
