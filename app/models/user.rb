class User < ActiveRecord::Base
  acts_as_authentic
  #translates :name_to_display
end
