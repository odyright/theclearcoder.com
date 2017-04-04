defmodule Blog.Web do
  @moduledoc """
  A module that keeps using definitions for controllers,
  views and so on.

  This can be used in your application as:

      use Blog.Web, :controller
      use Blog.Web, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below.
  """

  def model do
    quote do
      use Ecto.Schema

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
    end
  end

  def controller do
    quote do
      use Phoenix.Controller, namespace: Blog.Web

      import Ecto
      import Ecto.Query

      import Blog.Web.Router.Helpers
      import Blog.Web.Gettext
      import Blog.Web.Auth, only: [authenticate_user: 2]
    end
  end

  def view do
    quote do
      use Phoenix.View, root: "lib/blog/web/templates",
                        namespace: Blog.Web

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_csrf_token: 0, get_flash: 2, view_module: 1, action_name: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import Blog.Web.Router.Helpers
      import Blog.Web.ErrorHelpers
      import Blog.Web.Gettext

      import Blog.Web.Helpers.HtmlView, only: [to_html: 1]
    end
  end

  def router do
    quote do
      use Phoenix.Router

      import Blog.Web.Auth, only: [authenticate_user: 2]
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import Blog.Web.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
