defmodule ApiWeb.ProductController do
  use ApiWeb, :controller

  alias Api.Orders
  alias Api.Orders.Product

  action_fallback ApiWeb.FallbackController

  def index(conn, _params) do
    products = Orders.list_products()
    render(conn, "index.json", products: products)
  end

  def create(conn, %{"product" => product_params}) do
    with {:ok, %Product{} = product} <- Orders.create_product(product_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", product_path(conn, :show, product))
      |> render("show.json", product: product)
    end
  end

  def show(conn, %{"id" => id}) do
    product = Orders.get_product!(id)
    render(conn, "show.json", product: product)
  end

  def update(conn, %{"id" => id, "product" => product_params}) do
    product = Orders.get_product!(id)

    with {:ok, %Product{} = product} <- Orders.update_product(product, product_params) do
      render(conn, "show.json", product: product)
    end
  end

  def delete(conn, %{"id" => id}) do
    product = Orders.get_product!(id)
    with {:ok, %Product{}} <- Orders.delete_product(product) do
      send_resp(conn, :no_content, "")
    end
  end
end
