defmodule MyBlog.ContentFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MyBlog.Content` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        content: "some content",
        image: "some image",
        status: "some status",
        title: "some title"
      })
      |> MyBlog.Content.create_post()

    post
  end
end
