defmodule MyBlog.Access.OrganizationPolicy do
  use MyBlog.Access.Policy

  @impl true
  def context, do: "organizations"

  @impl true
  def policies() do
    [
      &MyBlog.Access.Check.has_permission/4,
      &is_owner/4
    ]
  end

  def is_owner(user, _context, _permission, _) do
    user.id == user.organization.owner_id
  end
end
