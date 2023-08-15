defmodule MyBlog.OrgFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MyBlog.Org` context.
  """

  @doc """
  Generate a organization.
  """
  def organization_fixture(attrs \\ %{}) do
    {:ok, organization} =
      attrs
      |> Enum.into(%{
        address: "some address",
        contact_email: "some contact_email",
        logo: "some logo",
        name: "some name"
      })
      |> MyBlog.Org.create_organization()

    organization
  end
end
