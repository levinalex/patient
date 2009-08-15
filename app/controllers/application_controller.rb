# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :given_name, :middle_name, :family_name, :family_name2, :birthdate, :identifier, :address
  
  before_filter :set_user_language
  
  helper_method :current_user
  
  prawnto :prawn => {
    :info => {
      :Title => "Result Report", :Author => "yoshi", :Subject => "",
      :Keywords => "lab test results", :Creator => "MasterLab",
      :Producer => "", :CreationDate => Time.now
    }
  }
    
  private
  
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
  
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
  
  def set_user_language
    I18n.locale = 'es'
  end
  
end
