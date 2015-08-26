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

        # To use caching storage such as memcached
        # https://devcenter.heroku.com/articles/rack-cache-memcached-rails31
        # http://railscasts.com/episodes/380-memcached-dalli
        # if stale?(@application)
        #   render json: @application
        # end
      end

      private

        def safe_params
          params.require(:application).permit()
        end

    end
  end
end
