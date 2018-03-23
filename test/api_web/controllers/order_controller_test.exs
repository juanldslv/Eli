defmodule ApiWeb.OrderControllerTest do
  use ApiWeb.ConnCase

  alias Api.Orders
  alias Api.Orders.Order

  @create_attrs %{destination: "some destination", discount: 42, order_id: 42, qty: 42, total: "120.5"}
  @update_attrs %{destination: "some updated destination", discount: 43, order_id: 43, qty: 43, total: "456.7"}
  @invalid_attrs %{destination: nil, discount: nil, order_id: nil, qty: nil, total: nil}

  def fixture(:order) do
    {:ok, order} = Orders.create_order(@create_attrs)
    order
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all orders", %{conn: conn} do
      conn = get conn, order_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create order" do
    test "renders order when data is valid", %{conn: conn} do
      conn = post conn, order_path(conn, :create), order: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, order_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "destination" => "some destination",
        "discount" => 42,
        "order_id" => 42,
        "qty" => 42,
        "total" => "120.5"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, order_path(conn, :create), order: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update order" do
    setup [:create_order]

    test "renders order when data is valid", %{conn: conn, order: %Order{id: id} = order} do
      conn = put conn, order_path(conn, :update, order), order: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, order_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "destination" => "some updated destination",
        "discount" => 43,
        "order_id" => 43,
        "qty" => 43,
        "total" => "456.7"}
    end

    test "renders errors when data is invalid", %{conn: conn, order: order} do
      conn = put conn, order_path(conn, :update, order), order: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete order" do
    setup [:create_order]

    test "deletes chosen order", %{conn: conn, order: order} do
      conn = delete conn, order_path(conn, :delete, order)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, order_path(conn, :show, order)
      end
    end
  end

  defp create_order(_) do
    order = fixture(:order)
    {:ok, order: order}
  end
end
