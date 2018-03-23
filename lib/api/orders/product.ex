defmodule Api.Orders.Product do
  use Ecto.Schema
  import Ecto.Changeset


  schema "products" do
    field :description, :string
    field :name, :string
    field :value, :decimal
    field :product_id, :integer

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:product_id,:name, :description, :value])
    |> validate_required([ :name, :description, :value])
    |> unique_constraint(:product_id)
  end
end
