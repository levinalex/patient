# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :given_name, :middle_name, :family_name, :family_name2, :birthdate, :identifier, :address
  
  before_filter :set_user_language
  
  prawnto :prawn => {
    :info => {
      :Title => "My title", :Author => "John Doe", :Subject => "My Subject",
      :Keywords => "test metadata ruby pdf dry", :Creator => "ACME Soft App", 
      :Producer => "", :CreationDate => Time.now, :Grok => "Test Property"
    }
  }
    
  private
  
  def set_user_language
    I18n.locale = 'es'
  end
  
end
