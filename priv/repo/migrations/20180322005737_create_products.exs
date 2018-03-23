defmodule Api.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :description, :string
      add :value, :decimal

      timestamps()
    end

  end
end
