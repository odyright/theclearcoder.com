defmodule Test.Context.Helpers do
  @moduledoc """
  Provides helper functions for common setup needs in tests.
  """

  alias Plug.Conn

  @doc """
  Creates a new user, puts the user in session, and returns the user 
  in the context.
  """
  def login_test_user(context) do
    user = Forge.saved_user
    conn = Conn.assign(context[:conn], :current_user, user)
    [conn: conn, user: user]
  end
end
