defmodule MyBlog.Access.PostPolicy do
  use MyBlog.Access.Policy

  @impl true
  def context, do: "posts"

  @impl true
  def policies() do
    [
      &MyBlog.Access.Check.has_permission/4,
      &is_author/4
    ]
  end

  def is_author(user, _context, _permission, %{author_id: id}) do
    user.id == id
  end

  def is_author(_, _, _, _), do: false
end
