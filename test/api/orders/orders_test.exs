defmodule Api.OrdersTest do
  use Api.DataCase

  alias Api.Orders

  describe "products" do
    alias Api.Orders.Product

    @valid_attrs %{description: "some description", name: "some name", value: "120.5"}
    @update_attrs %{description: "some updated description", name: "some updated name", value: "456.7"}
    @invalid_attrs %{description: nil, name: nil, value: nil}

    def product_fixture(attrs \\ %{}) do
      {:ok, product} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Orders.create_product()

      product
    end

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Orders.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Orders.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      assert {:ok, %Product{} = product} = Orders.create_product(@valid_attrs)
      assert product.description == "some description"
      assert product.name == "some name"
      assert product.value == Decimal.new("120.5")
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Orders.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      assert {:ok, product} = Orders.update_product(product, @update_attrs)
      assert %Product{} = product
      assert product.description == "some updated description"
      assert product.name == "some updated name"
      assert product.value == Decimal.new("456.7")
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Orders.update_product(product, @invalid_attrs)
      assert product == Orders.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Orders.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Orders.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Orders.change_product(product)
    end
  end

  describe "users" do
    alias Api.Orders.User

    @valid_attrs %{email: "some email", name: "some name"}
    @update_attrs %{email: "some updated email", name: "some updated name"}
    @invalid_attrs %{email: nil, name: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Orders.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Orders.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Orders.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Orders.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.name == "some name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Orders.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Orders.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.email == "some updated email"
      assert user.name == "some updated name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Orders.update_user(user, @invalid_attrs)
      assert user == Orders.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Orders.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Orders.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Orders.change_user(user)
    end
  end

  describe "orders" do
    alias Api.Orders.Order

    @valid_attrs %{destination: "some destination", discount: 42, order_id: 42, qty: 42, total: "120.5"}
    @update_attrs %{destination: "some updated destination", discount: 43, order_id: 43, qty: 43, total: "456.7"}
    @invalid_attrs %{destination: nil, discount: nil, order_id: nil, qty: nil, total: nil}

    def order_fixture(attrs \\ %{}) do
      {:ok, order} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Orders.create_order()

      order
    end

    test "list_orders/0 returns all orders" do
      order = order_fixture()
      assert Orders.list_orders() == [order]
    end

    test "get_order!/1 returns the order with given id" do
      order = order_fixture()
      assert Orders.get_order!(order.id) == order
    end

    test "create_order/1 with valid data creates a order" do
      assert {:ok, %Order{} = order} = Orders.create_order(@valid_attrs)
      assert order.destination == "some destination"
      assert order.discount == 42
      assert order.order_id == 42
      assert order.qty == 42
      assert order.total == Decimal.new("120.5")
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Orders.create_order(@invalid_attrs)
    end

    test "update_order/2 with valid data updates the order" do
      order = order_fixture()
      assert {:ok, order} = Orders.update_order(order, @update_attrs)
      assert %Order{} = order
      assert order.destination == "some updated destination"
      assert order.discount == 43
      assert order.order_id == 43
      assert order.qty == 43
      assert order.total == Decimal.new("456.7")
    end

    test "update_order/2 with invalid data returns error changeset" do
      order = order_fixture()
      assert {:error, %Ecto.Changeset{}} = Orders.update_order(order, @invalid_attrs)
      assert order == Orders.get_order!(order.id)
    end

    test "delete_order/1 deletes the order" do
      order = order_fixture()
      assert {:ok, %Order{}} = Orders.delete_order(order)
      assert_raise Ecto.NoResultsError, fn -> Orders.get_order!(order.id) end
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = Orders.change_order(order)
    end
  end
end
