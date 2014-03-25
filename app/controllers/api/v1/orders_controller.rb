module Api
  module V1
    class OrdersController < Api::BaseController

      respond_to :json

      # curl http://localhost:3010/api/orders -H 'Authorization: Token token="111"'
      def index
        if params[:q].present?
          respond_with Order.search_by_keyword(params[:q])
        else
          respond_with Order.order('created_at DESC').limit(20)
        end
      end

      # curl http://localhost:3010/api/orders/:id -H 'Authorization: Token token="111"'
      def show
        @order = Order.find(params[:id])
        respond_with :api, @order
      end

      # curl -v -H 'Authorization: Token token="111"' -H "Content-type: application/json" -X POST -d '{"order": {"uid":"11101"}}' http://localhost:3010/api/orders
      def create
        @order = Order.create(safe_params)
        respond_with :api, @order
      end

      private

        def safe_params
          params.require(:order).permit(:uid, :source, :client_email, :country, :city, :products_count,
                                        :date, :currency, :amount, :shipping, :total_price, :gift,
                                        :coupon, :coupon_code, :url)
        end

    end
  end
end