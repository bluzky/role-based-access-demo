defmodule MyBlogWeb.UserHTML do
  use MyBlogWeb, :html

  embed_templates "user_html/*"

  @doc """
  Renders a organization form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def user_form(assigns)
end
