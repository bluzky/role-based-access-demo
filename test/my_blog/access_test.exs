defmodule MyBlog.AccessTest do
  use MyBlog.DataCase

  alias MyBlog.Access

  describe "roles" do
    alias MyBlog.Access.Role

    import MyBlog.AccessFixtures

    @invalid_attrs %{code: nil, filters: nil, name: nil, permissions: nil, scope: nil}

    test "list_roles/0 returns all roles" do
      role = role_fixture()
      assert Access.list_roles() == [role]
    end

    test "get_role!/1 returns the role with given id" do
      role = role_fixture()
      assert Access.get_role!(role.id) == role
    end

    test "create_role/1 with valid data creates a role" do
      valid_attrs = %{code: "some code", filters: %{}, name: "some name", permissions: %{}, scope: "some scope"}

      assert {:ok, %Role{} = role} = Access.create_role(valid_attrs)
      assert role.code == "some code"
      assert role.filters == %{}
      assert role.name == "some name"
      assert role.permissions == %{}
      assert role.scope == "some scope"
    end

    test "create_role/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Access.create_role(@invalid_attrs)
    end

    test "update_role/2 with valid data updates the role" do
      role = role_fixture()
      update_attrs = %{code: "some updated code", filters: %{}, name: "some updated name", permissions: %{}, scope: "some updated scope"}

      assert {:ok, %Role{} = role} = Access.update_role(role, update_attrs)
      assert role.code == "some updated code"
      assert role.filters == %{}
      assert role.name == "some updated name"
      assert role.permissions == %{}
      assert role.scope == "some updated scope"
    end

    test "update_role/2 with invalid data returns error changeset" do
      role = role_fixture()
      assert {:error, %Ecto.Changeset{}} = Access.update_role(role, @invalid_attrs)
      assert role == Access.get_role!(role.id)
    end

    test "delete_role/1 deletes the role" do
      role = role_fixture()
      assert {:ok, %Role{}} = Access.delete_role(role)
      assert_raise Ecto.NoResultsError, fn -> Access.get_role!(role.id) end
    end

    test "change_role/1 returns a role changeset" do
      role = role_fixture()
      assert %Ecto.Changeset{} = Access.change_role(role)
    end
  end
end
