module Api
  module V1
    class MetricsController < Api::BaseController

      # curl https://api.domain.com/v1/metrics/all \
      # -X GET \
      # -u 000:111 \
      # -d interval=month \
      # -d start-date=2015-01-01 \
      # -d end-date=2015-08-26 \
      # -d geo=GB \
      # -d plan="PRO Plan" |

      def all
      end

    end
  end
end


