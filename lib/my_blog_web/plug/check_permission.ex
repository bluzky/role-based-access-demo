defmodule MyBlogWeb.Plugs.CheckPermissions do
  import Plug.Conn
  import Phoenix.Controller, only: [action_name: 1, put_view: 2, render: 2]
  require Logger

  alias MyBlog.Repo

  def init(opts), do: opts

  def call(conn, opts) do
    user = get_user(conn)
    {policy_module, opts} = Keyword.pop!(opts, :policy)
    required_permission = get_required_permission(conn, opts)
    default_access = Keyword.get(opts, :default_access, :deny)
    resource_extractor = Keyword.get(opts, :resource_extractor, nil)

    # TODO: config module
    MyBlog.Repo.put_actor(user)
    MyBlog.Repo.put_tenant(user.organization_id)

    resource =
      if resource_extractor do
        resource_extractor.(conn)
      end

    cond do
      required_permission == :not_set && default_access == :allow ->
        Logger.info("no permission required")

        conn

      required_permission != :not_set &&
          policy_module.authorized?(user, required_permission, resource) ->
        Logger.info("access allowed")
        conn

      true ->
        Logger.info("access denied")

        conn
        |> put_status(:forbidden)
        |> put_view(MyBlogWeb.ErrorHTML)
        |> render("403.html")
        |> halt()
    end
  end

  defp get_user(conn) do
    user = conn.assigns.current_user
    Repo.preload(user, :role)
  end

  defp get_required_permission(conn, opts) do
    action = action_name(conn)

    opts
    |> Keyword.fetch!(:actions)
    |> Keyword.fetch(action)
    |> case do
      {:ok, permission} -> permission
      :error -> :not_set
    end
  end
end
