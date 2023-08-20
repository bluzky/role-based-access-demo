defmodule MyBlog.Repo do
  use Ecto.Repo,
    otp_app: :my_blog,
    adapter: Ecto.Adapters.Postgres

  @tenant_key {__MODULE__, :tenant}
  @actor_key {__MODULE__, :actor}

  def put_tenant(tenant) do
    Process.put(@tenant_key, tenant)
  end

  def get_tenant() do
    Process.get(@tenant_key)
  end

  def put_actor(actor) do
    Process.put(@actor_key, actor)
  end

  def get_actor() do
    Process.get(@actor_key)
  end

  @impl true
  def default_options(_operation) do
    [tenant: get_tenant(), actor: get_actor()]
  end

  @impl true
  def prepare_query(_operation, query, opts) do
    if opts[:schema_migration] do
      {query, opts}
    else
      query = apply_tenant_policy(query, opts[:tenant])
      query = apply_actor_policy(query, opts[:actor])

      {query, opts}
    end
  end

  # Check if schema define `tenant_scope` function
  # and apply it to query
  # if not, skip tenant scoping
  defp apply_tenant_policy(query, false), do: query

  defp apply_tenant_policy(%{from: %{source: {_, module}}} = query, tenant) do
    # if module is configured to use multitenancy
    if function_exported?(module, :tenant_scope, 2) do
      module.tenant_scope(query, tenant)
    else
      query
    end
  end

  # Actor is loosely required
  # if schema define `actor_scope` function then apply it to query
  # if not, skip actor scoping
  defp apply_actor_policy(query, false), do: query

  defp apply_actor_policy(%{from: %{source: {_, module}}} = query, actor) do
    if function_exported?(module, :actor_scope, 2) do
      if actor do
        module.actor_scope(query, actor)
      else
        raise "Actor is missing, Set actor with `put_actor/1`"
      end
    else
      # where(query, ^condition)
      query
    end
  end
end
