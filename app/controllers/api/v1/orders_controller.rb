module Api
  module V1
    class OrdersController < Api::BaseController

      respond_to :json

      # curl http://localhost:3010/api/orders -H 'Authorization: Token token="111"'
      # curl http://localhost:3010/api/orders?q=429 -H 'Authorization: Token token="111"'
      def index
        @orders = Order.order('created_at DESC').limit(20)
        if params[:q].present?
          @orders = Order.search_by_keyword(params[:q])
        end
        render json: @orders, status: 200
      end

      # curl http://localhost:3010/api/orders/:id -H 'Authorization: Token token="111"'
      def show
        @order = Order.find(params[:id])
        render json: @order, status: 200
      end

      # curl -v -H 'Authorization: Token token="111"' -H "Content-type: application/json" -X POST -d '{"order": {"date": "2014-07-01 14:50:28", "currency": "CAD", "city": "Paris", "country": "Canada", "client_email": "d@email.com", "uid": "0000099"}}' http://localhost:3010/api/orders
      def create
        @order = @current_application.orders.new(safe_params)
        if @order.save
          #render json: @order, status: :created, location: @order
          render nothing: true, status: :created, location: @order
        else
          render json: @order.errors, status: 422
        end
      end

      private

        def safe_params
          params.require(:order).permit(:uid, :client_email, :country, :city, :products_count,
                                        :date, :currency, :amount, :shipping, :total_price, :gift,
                                        :coupon, :coupon_code, :url, :tax, :source)
        end

    end
  end
end