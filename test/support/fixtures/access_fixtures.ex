defmodule MyBlog.AccessFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MyBlog.Access` context.
  """

  @doc """
  Generate a role.
  """
  def role_fixture(attrs \\ %{}) do
    {:ok, role} =
      attrs
      |> Enum.into(%{
        code: "some code",
        filters: %{},
        name: "some name",
        permissions: %{},
        scope: "some scope"
      })
      |> MyBlog.Access.create_role()

    role
  end
end
