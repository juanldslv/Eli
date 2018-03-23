defmodule ApiWeb.OrderView do
  use ApiWeb, :view
  alias ApiWeb.OrderView

  def render("index.json", %{orders: orders}) do
    %{data: render_many(orders, OrderView, "order.json")}
  end

  def render("show.json", %{order: order}) do
    %{data: render_one(order, OrderView, "order.json")}
  end

  def render("order.json", %{order: order}) do
    %{id: order.id,
      order_id: order.order_id,
      qty: order.qty,
      discount: order.discount,
      total: order.total,
      destination: order.destination}
  end
end
