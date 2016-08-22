defmodule Contactapi.Repo.Migrations.CreateVolunteerForm do
  use Ecto.Migration

  def change do
    create table(:volunteerforms) do
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :gender, :string
      add :country, :string
      add :city, :string
      add :age, :integer
      add :phone_number, :string
      add :participation_type, :string

      timestamps()
    end

  end
end
