module Api
  module V1
    class ApplicationsController < Api::BaseController

      respond_to :json

      # curl http://localhost:3010/api/applications -H 'Authorization: Token token="111"'
      def index
        @applications = Application.order('name').limit(20)
      end

      # curl http://localhost:3010/api/applications/:id -H 'Authorization: Token token="111"'
      def show
        @application = Application.find(params[:id])
      end

      private

        def safe_params
          params.require(:application).permit()
        end

    end
  end
end
