defmodule Contactapi.BasicForm do
  use Contactapi.Web, :model

  schema "basicforms" do
    field :name, :string
    field :subject, :string
    field :email, :string
    field :message, :string
    field :read, :boolean, default: false

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :subject, :email, :message, :read])
    |> validate_required([:name, :subject, :email, :message, :read])
  end
end
