defmodule MyBlogWeb.PostController do
  use MyBlogWeb, :controller

  plug(MyBlogWeb.Plugs.CheckPermissions,
    policy: MyBlog.Access.PostPolicy,
    actions: [
      index: "read",
      show: "read",
      create: "create",
      delete: "delete"
    ],
    default_access: :allow,
    # function receives conn and returns resource
    resource_extractor: &__MODULE__.get_post/1
  )

  alias MyBlog.Content
  alias MyBlog.Content.Post

  def index(conn, _params) do
    posts = Content.list_posts()
    render(conn, :index, posts: posts)
  end

  def new(conn, _params) do
    changeset = Content.change_post(%Post{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    case Content.create_post(post_params, conn.assigns.current_user) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: ~p"/posts/#{post}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Content.get_post!(id)
    render(conn, :show, post: post)
  end

  def edit(conn, %{"id" => id}) do
    post = Content.get_post!(id)
    changeset = Content.change_post(post)
    render(conn, :edit, post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Content.get_post!(id)

    case Content.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: ~p"/posts/#{post}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Content.get_post!(id)
    {:ok, _post} = Content.delete_post(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: ~p"/posts")
  end

  # load post from query
  def get_post(conn) do
    if conn.params["id"] do
      Content.get_post!(conn.params["id"])
    end
  end
end
