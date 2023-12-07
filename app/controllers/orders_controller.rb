class OrdersController < ApplicationController

  def index
    @orders = current_user.orders.includes(order_items: :item)
  end

  def create
  end
  
end