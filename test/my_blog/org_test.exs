defmodule MyBlog.OrgTest do
  use MyBlog.DataCase

  alias MyBlog.Org

  describe "organizations" do
    alias MyBlog.Org.Organization

    import MyBlog.OrgFixtures

    @invalid_attrs %{address: nil, contact_email: nil, logo: nil, name: nil}

    test "list_organizations/0 returns all organizations" do
      organization = organization_fixture()
      assert Org.list_organizations() == [organization]
    end

    test "get_organization!/1 returns the organization with given id" do
      organization = organization_fixture()
      assert Org.get_organization!(organization.id) == organization
    end

    test "create_organization/1 with valid data creates a organization" do
      valid_attrs = %{address: "some address", contact_email: "some contact_email", logo: "some logo", name: "some name"}

      assert {:ok, %Organization{} = organization} = Org.create_organization(valid_attrs)
      assert organization.address == "some address"
      assert organization.contact_email == "some contact_email"
      assert organization.logo == "some logo"
      assert organization.name == "some name"
    end

    test "create_organization/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Org.create_organization(@invalid_attrs)
    end

    test "update_organization/2 with valid data updates the organization" do
      organization = organization_fixture()
      update_attrs = %{address: "some updated address", contact_email: "some updated contact_email", logo: "some updated logo", name: "some updated name"}

      assert {:ok, %Organization{} = organization} = Org.update_organization(organization, update_attrs)
      assert organization.address == "some updated address"
      assert organization.contact_email == "some updated contact_email"
      assert organization.logo == "some updated logo"
      assert organization.name == "some updated name"
    end

    test "update_organization/2 with invalid data returns error changeset" do
      organization = organization_fixture()
      assert {:error, %Ecto.Changeset{}} = Org.update_organization(organization, @invalid_attrs)
      assert organization == Org.get_organization!(organization.id)
    end

    test "delete_organization/1 deletes the organization" do
      organization = organization_fixture()
      assert {:ok, %Organization{}} = Org.delete_organization(organization)
      assert_raise Ecto.NoResultsError, fn -> Org.get_organization!(organization.id) end
    end

    test "change_organization/1 returns a organization changeset" do
      organization = organization_fixture()
      assert %Ecto.Changeset{} = Org.change_organization(organization)
    end
  end
end
