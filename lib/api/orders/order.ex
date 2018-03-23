defmodule Api.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset


  schema "orders" do
    field :destination, :string
    field :discount, :integer
    field :order_id, :integer
    field :qty, :integer
    field :total, :decimal

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:order_id, :qty, :discount, :total, :destination])
    |> validate_required([ :qty, :discount, :total, :destination])
    |> unique_constraint(:order_id)
  end
end
