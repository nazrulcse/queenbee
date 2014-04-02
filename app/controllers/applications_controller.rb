class ApplicationsController < BaseController

  def index
  	@applications = Application.order('name').limit(20)
  end

  def show
  	@application = Application.find(params[:id])
  end

end
