defmodule MyBlog.Access.Check do
  alias MyBlog.Access.Permissions

  def has_permission(user, context, permission, _resource) do
    Permissions.user_has_permission?(user, {context, permission})
  end
end
