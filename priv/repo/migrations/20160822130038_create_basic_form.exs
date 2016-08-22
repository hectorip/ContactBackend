defmodule Contactapi.Repo.Migrations.CreateBasicForm do
  use Ecto.Migration

  def change do
    create table(:basicforms) do
      add :name, :string
      add :subject, :string
      add :email, :string
      add :message, :text
      add :read, :boolean, default: false, null: false

      timestamps()
    end

  end
end
