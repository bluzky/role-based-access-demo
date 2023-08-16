defmodule MyBlogWeb.RoleController do
  use MyBlogWeb, :controller

  alias MyBlog.Access
  alias MyBlog.Access.Role

  def index(conn, _params) do
    roles = Access.list_roles()
    render(conn, :index, roles: roles)
  end

  def new(conn, _params) do
    changeset = Access.change_role(%Role{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"role" => role_params}) do
    case Access.create_role(role_params) do
      {:ok, role} ->
        conn
        |> put_flash(:info, "Role created successfully.")
        |> redirect(to: ~p"/roles/#{role}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    role = Access.get_role!(id)
    render(conn, :show, role: role)
  end

  def edit(conn, %{"id" => id}) do
    role = Access.get_role!(id)
    changeset = Access.change_role(role)
    render(conn, :edit, role: role, changeset: changeset)
  end

  def update(conn, %{"id" => id, "role" => role_params}) do
    role = Access.get_role!(id)

    case Access.update_role(role, role_params) do
      {:ok, role} ->
        conn
        |> put_flash(:info, "Role updated successfully.")
        |> redirect(to: ~p"/roles/#{role}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, role: role, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    role = Access.get_role!(id)
    {:ok, _role} = Access.delete_role(role)

    conn
    |> put_flash(:info, "Role deleted successfully.")
    |> redirect(to: ~p"/roles")
  end
end
