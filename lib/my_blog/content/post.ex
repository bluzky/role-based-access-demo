defmodule MyBlog.Content.Post do
  use Ecto.Schema
  use MyBlog.Access.Multitenancy, column: :organization_id
  import Ecto.Changeset

  schema "posts" do
    field :content, :string
    field :image, :string
    field :status, Ecto.Enum, values: [:draft, :published], default: :draft
    field :title, :string
    belongs_to :author, MyBlog.Accounts.User
    belongs_to :organization, MyBlog.Org.Organization

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :image, :content, :status, :author_id, :organization_id])
    |> validate_required([:title, :content, :author_id, :organization_id])
  end
end
