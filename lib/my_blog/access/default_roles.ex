defmodule MyBlog.Access.DefaultRoles do
  def all do
    [
      %{
        name: "admin",
        code: "admin",
        permissions: %{
          users: ["create", "read", "update", "delete"],
          posts: ["create", "read", "update", "delete"],
          organizations: ["read", "update", "delete"]
        }
      },
      %{
        name: "editor",
        code: "editor",
        permissions: %{
          posts: ["create", "read", "update", "delete"]
        }
      },
      %{
        name: "reviewer",
        code: "reviewer",
        permissions: %{
          posts: ~w(read)
        }
      }
    ]
  end
end
