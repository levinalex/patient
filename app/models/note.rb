class Note < ActiveRecord::Base
  #attr_protected :id
  belongs_to :department
  belongs_to :noticeable, :polymorphic => true

  def department_name
    department.name
  end
end
