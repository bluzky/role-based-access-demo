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

  def user_has_permission?(user, permission) do
    has_permission?(user.role.permissions, permission)
  end

  # def validate_permissions(changeset, field) do
  #   validate_change(changeset, field, fn _field, permissions ->
  #     permissions
  #     |> Enum.reject(&has_permission?(all(), &1))
  #     |> case do
  #       [] -> []
  #       invalid_permissions -> [{field, {"invalid permissions", invalid_permissions}}]
  #     end
  #   end)
  # end

  # check if the given permissions are valid
  def has_permission?(permissions, {context, actions}) do
    exists?(context, permissions) && actions_valid?(context, actions, permissions)
  end

  defp exists?(context, permissions), do: Map.has_key?(permissions, context)

  defp actions_valid?(context, given_action, permissions) when is_binary(given_action) do
    actions_valid?(context, [given_action], permissions)
  end

  defp actions_valid?(context, given_actions, permissions) when is_list(given_actions) do
    defined_actions = Map.get(permissions, context)
    Enum.all?(given_actions, &(&1 in defined_actions))
  end

  defp actions_valid?(_, _, _), do: false
end
