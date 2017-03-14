class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :check_subscribtion

  protected

  def check_subscribtion
    redirect_to new_subscriber_path if current_user && !current_user.is_subscriber?
  end

end
