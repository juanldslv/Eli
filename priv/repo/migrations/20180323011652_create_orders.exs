defmodule Api.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :order_id, :integer
      add :qty, :integer
      add :discount, :integer
      add :total, :decimal
      add :destination, :string

      timestamps()
    end

    create unique_index(:orders, [:order_id])
  end
end
