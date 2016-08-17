defmodule Contactapi.Repo.Migrations.AddUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :username, :string, null: false
      add :password_hash, :string
      timestamps
    end

    create unique_index(:users, [:username])
  end
end