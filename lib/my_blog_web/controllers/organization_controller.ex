defmodule MyBlogWeb.OrganizationController do
  use MyBlogWeb, :controller

  alias MyBlog.Org
  alias MyBlog.Org.Organization

  plug(MyBlogWeb.Plugs.CheckPermissions,
    policy: MyBlog.Access.OrganizationPolicy,
    actions: [
      show: "read",
      update: "update",
      edit: "update",
      delete: "delete"
    ],
    default_access: :deny
  )

  def index(conn, _params) do
    organizations = Org.list_organizations()
    render(conn, :index, organizations: organizations)
  end

  def new(conn, _params) do
    changeset = Org.change_organization(%Organization{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"organization" => organization_params}) do
    case Org.create_organization(organization_params) do
      {:ok, organization} ->
        conn
        |> put_flash(:info, "Organization created successfully.")
        |> redirect(to: ~p"/organizations/#{organization}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    organization = Org.get_organization!(id)
    render(conn, :show, organization: organization)
  end

  def edit(conn, %{"id" => id}) do
    organization = Org.get_organization!(id)
    changeset = Org.change_organization(organization)
    render(conn, :edit, organization: organization, changeset: changeset)
  end

  def update(conn, %{"id" => id, "organization" => organization_params}) do
    organization = Org.get_organization!(id)

    case Org.update_organization(organization, organization_params) do
      {:ok, organization} ->
        conn
        |> put_flash(:info, "Organization updated successfully.")
        |> redirect(to: ~p"/organizations/#{organization}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, organization: organization, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    organization = Org.get_organization!(id)
    {:ok, _organization} = Org.delete_organization(organization)

    conn
    |> put_flash(:info, "Organization deleted successfully.")
    |> redirect(to: ~p"/organizations")
  end
end
