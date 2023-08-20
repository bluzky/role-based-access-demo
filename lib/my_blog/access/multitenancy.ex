defmodule MyBlog.Access.Multitenancy do
  defmacro __using__(opts) do
    tenant_column = Keyword.fetch!(opts, :column)

    quote do
      import Ecto.Query

      def tenant_scope(query, tenant) do
        if tenant do
          condition = [{unquote(tenant_column), tenant}]
          where(query, ^condition)
        else
          raise "No tenant provided"
        end
      end

      defoverridable(tenant_scope: 2)
    end
  end
end
