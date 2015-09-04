module Api
  module V1
    class MetricsController < Api::BaseController
      before_action :set_period

      # curl https://api.domain.com/v1/metrics/all \
      # -X GET \
      # -u 000:111 \
      # -d interval=month \
      # -d start-date=2015-01-01 \
      # -d end-date=2015-08-26 \
      # -d geo=GB \
      # -d plan="PRO Plan" |

      # curl http://localhost:3010/api/metrics/all -H 'Authorization: Token token="111"'
      def all
        @application = @current_application
      end

      def mrr

      end

      private

      def set_period
        now = Time.zone.now.beginning_of_day
        start_date = params[:start_date] || now.beginning_of_day - 7.days
        end_date   = params[:end_date] || now.end_of_day
      end

    end
  end
end


