defmodule Api.Orders.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :email, :string
    field :name, :string
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:user_id,:name, :email])
    |> validate_required([:name, :email])
    |> unique_constraint(:user_id)
  end
end
