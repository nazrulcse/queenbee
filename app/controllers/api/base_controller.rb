class Api::BaseController < ApplicationController
  before_filter :restrict_access

  private

	  def restrict_access
	    if request.method != "OPTIONS"
	      authenticate_or_request_with_http_token do |token, options|
          api_key = Application.where(auth_token: token).any? && Application.where(auth_token: token).first.active?
          @current_application = Application.where(auth_token: token).first if api_key
        end
	    end
	  end

end