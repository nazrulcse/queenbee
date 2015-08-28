module Api
  module V1
    class OrdersController < Api::BaseController
      before_action :set_order, only: :update

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
          render json: @order, status: :created
        else
          render json: @order.errors.full_messages.to_sentence, status: 422
          # puts "**** #{@order.errors.full_messages.to_sentence} ****"
        end
      end

      # curl -v -H 'Authorization: Token token="111"' -H "Content-type: application/json" -X PUT -d '{"order": {"date": "2000-01-01 00:00:00", "currency": "JPY", "city": "Tokyo", "country": "Japon" }}' http://localhost:3010/api/orders/0000099
      def update
        if @order.update(safe_params)
          render :show, status: :ok, location: @order
        else
          render json: @application.errors.full_messages.to_sentence, status: :unprocessable_entity
        end
      end

      private

        def safe_params
          params.require(:order).permit(:uid, :client_email, :country, :city, :products_count,
                                        :date, :currency, :amount, :shipping, :total_price, :gift,
                                        :coupon, :coupon_code, :url, :tax, :source, :subscribed_at,
                                        :unsubscribed_at, :fees, :referral)
        end

        def set_order
          @order = @current_application.orders.find_by(uid: params[:id])
        end

    end
  end
end
