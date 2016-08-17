defmodule Contactapi.User do
  """
  User Model
  """

  schema "users" do
    field :name, :string
    field :email, :string
    field :username, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    timestamps
  end

  def changeset(mode, params \\ :empty) do
    model
      |> cast(params, ~w(name username), [])
      |> validate_length(:username, min: 4, max:20)
  end

  def registration_changeset(model, params) do
    model
      |> changeset(params)
      |> cast(params, ~w(password), [])
      |> validate_length(:password, min: 6, max: 100)
  end

end