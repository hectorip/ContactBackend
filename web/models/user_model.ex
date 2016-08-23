defmodule Contactapi.User do
  """
  User Model
  """
  use Contactapi.Web, :model

  schema "users" do
    field :name, :string
    field :email, :string
    field :username, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    timestamps
  end

  def changeset(model, params \\ :empty) do
    model
      |> cast(params, ~w(name username email), [])
      |> validate_length(:username, min: 4, max: 20)
  end

  def registration_changeset(model, params) do
    model
      |> changeset(params)
      |> cast(params, ~w(password), [])
      |> validate_length(:password, min: 6, max: 100)
      |> put_hashed_password
  end

  def put_hashed_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end
end