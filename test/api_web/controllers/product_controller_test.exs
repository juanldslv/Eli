defmodule ApiWeb.ProductControllerTest do
  use ApiWeb.ConnCase

  alias Api.Orders
  alias Api.Orders.Product

  @create_attrs %{description: "some description", name: "some name", value: "120.5"}
  @update_attrs %{description: "some updated description", name: "some updated name", value: "456.7"}
  @invalid_attrs %{description: nil, name: nil, value: nil}

  def fixture(:product) do
    {:ok, product} = Orders.create_product(@create_attrs)
    product
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all products", %{conn: conn} do
      conn = get conn, product_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create product" do
    test "renders product when data is valid", %{conn: conn} do
      conn = post conn, product_path(conn, :create), product: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, product_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "description" => "some description",
        "name" => "some name",
        "value" => "120.5"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, product_path(conn, :create), product: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update product" do
    setup [:create_product]

    test "renders product when data is valid", %{conn: conn, product: %Product{id: id} = product} do
      conn = put conn, product_path(conn, :update, product), product: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, product_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "description" => "some updated description",
        "name" => "some updated name",
        "value" => "456.7"}
    end

    test "renders errors when data is invalid", %{conn: conn, product: product} do
      conn = put conn, product_path(conn, :update, product), product: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete product" do
    setup [:create_product]

    test "deletes chosen product", %{conn: conn, product: product} do
      conn = delete conn, product_path(conn, :delete, product)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, product_path(conn, :show, product)
      end
    end
  end

  defp create_product(_) do
    product = fixture(:product)
    {:ok, product: product}
  end
end
