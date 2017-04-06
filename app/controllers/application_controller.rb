class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  APP_DOMAIN = 'www.certifiedpeng.com'
  before_filter :ensure_domain

  def ensure_domain
    unless request.env['HTTP_HOST'] == APP_DOMAIN || Rails.env.development?
      redirect_to "http://#{APP_DOMAIN}", status: 301
    end
  end
end
