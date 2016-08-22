defmodule Contactapi.VolunteerForm do
  use Contactapi.Web, :model

  schema "volunteerforms" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :gender, :string
    field :country, :string
    field :city, :string
    field :age, :string
    field :phone_number, :string
    field :participation_type, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:first_name, :last_name, :email, :gender, :country, :city, :age, :phone_number, :participation_type])
    |> validate_required([:first_name, :last_name, :email, :gender, :country, :city, :age, :phone_number, :participation_type])
  end
end
