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


end