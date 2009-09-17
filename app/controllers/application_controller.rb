class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :password_confirmation, :given_name, :middle_name, :family_name, :family_name2, :birthdate, :identifier, :email, :phone, :address, :type, :insurance_provider_id
  
  before_filter :set_user_language
  before_filter :set_active_tab
  
  helper_method :current_user_session, :current_user
  
  prawnto :prawn => {
    :info => {
      :Title => "Result Report", :Author => "MasterLab", :Subject => "",
      :Keywords => "lab test results", :Creator => "MasterLab",
      :Producer => "", :CreationDate => Time.now
    }
  }
  
  protected
  
  def set_active_tab
    @active_tab ||= self.controller_name.to_sym
  end
    
  private
  
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
  
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
  
  def require_user
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to login_url
      return false
    end
  end
  
  def require_no_user
    if current_user
      store_location
      flash[:notice] = "You must be logged out to access this page"
      redirect_to login_url
      return false
    end
  end
  
  def store_location
    session[:return_to] = request.request_uri
  end
  
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
  
  def set_user_language
    if current_user
      I18n.locale = current_user.language
    else
      I18n.locale = "es"
    end
  end
end
