class User < ActiveRecord::Base
  acts_as_authentic
  #translates :name_to_display
  
  def admin?
    true
  end
end
