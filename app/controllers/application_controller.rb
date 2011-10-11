# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.


class ApplicationController < ActionController::Base

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :authenticate_user!
  before_filter :instantiate_controller_and_action_names
              # Scrub sensitive parameters from your log
              # filter_parameter_logging :password
  layout :layout_by_resource

  unless ActionController::Base.consider_all_requests_local
    rescue_from Exception, :with => :render_error
    rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found
    rescue_from ActionController::RoutingError, :with => :render_not_found
    rescue_from ActionController::UnknownController, :with => :render_not_found
    rescue_from ActionController::UnknownAction, :with => :render_not_found
  end

  private

  private

  def render_not_found(exception)
    log_error(exception)
    #render :template => "/error/404.html.erb", :status => 404
  end

  def render_error(exception)
    log_error(exception)
   # render :template => "/error/500.html.erb", :status => 500
  end

  protected

  def layout_by_resource
    if devise_controller?
      "registrations"
    else
      "application"
    end
  end

  private

  def instantiate_controller_and_action_names
    @current_action = action_name
    @current_controller = controller_name
  end


end
