class User < ActiveRecord::Base
  acts_as_authentic
  #translates :prefix :suffix
  
  def name_to_display
    full_name = [prefix, first_name, last_name].join(' ').squeeze(' ').strip
    [full_name, suffix].join(', ') if suffix
  end
end
