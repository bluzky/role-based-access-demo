defmodule MyBlog.Access.Policy do
  # return list of policies
  @callback context() :: String.t()
  @callback policies() :: [any()]

  defmacro __using__(_) do
    quote do
      @behaviour MyBlog.Access.Policy

      def authorized?(user, permission, resource \\ nil) do
        Enum.any?(policies(), fn
          check_fn when is_function(check_fn, 4) ->
            check_fn.(user, context(), permission, resource)

          check_mod ->
            check_mod.check(user, context(), permission, resource)
        end)
      end
    end
  end
end
