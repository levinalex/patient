class DoctorsController < ApplicationController
  def index
    if params[:q]
      @doctors = Doctor.all(:conditions => ['name LIKE ?', "%#{params[:q]}%"])
    else
      @doctors = Doctor.all
    end
  end
end
