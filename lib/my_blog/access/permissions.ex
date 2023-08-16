defmodule MyBlog.Access.Permissions do
  def config do
    %{
      organizations: %{
        permissions: ~w(read update),
        default: "allow"
      },
      posts: %{
        permissions: ~w(create read update delete),
        default: "allow"
      },
      users: %{
        permissions: ~w(create read update delete),
        default: "deny"
      },
      default: "allow"
    }
  end
end
