class OrdersController < ApplicationController

  def index
  	@orders = Order.order('created_at DESC').limit(20)
  end

  def show
  	@order = Order.find(params[:id])
  end

end
