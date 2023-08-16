defmodule MyBlog.Access.DefaultRoles do
  def all do
    [
      %{
        name: "admin",
        code: "admin",
        permissions: %{
          posts: "all",
          users: "all"
        }
      },
      %{
        name: "editor",
        code: "editor",
        permissions: %{
          posts: "all",
          users: "none"
        }
      },
      %{
        name: "reviewer",
        code: "reviewer",
        permissions: %{
          users: "none",
          posts: ~w(read)
        }
      }
    ]
  end
end
