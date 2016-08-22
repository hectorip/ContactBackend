defmodule Contactapi.Repo.Migrations.ChangingAgeType do
  use Ecto.Migration

  def change do
     alter table(:volunteerforms) do
        modify :age, :string
      end

  end
end
