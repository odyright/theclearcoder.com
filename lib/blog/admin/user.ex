defmodule Blog.Admin.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Blog.Admin.User

  schema "users" do
    field :name, :string
    field :username, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, ~w(name username))
    |> validate_required([:name, :username])
    |> validate_length(:username, min: 1, max: 20)
  end

  def registration_changeset(user, params) do
    user
    |> changeset(params)
    |> cast(params, ~w(password))
    |> validate_length(:password, min: 6, max: 100)
    |> put_pass_hash()
  end 

  @doc """
  Returns a branding `Ecto.Changeset` given the params.
  """
  def new_changeset() do
    User.changeset(%User{})
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end
end
