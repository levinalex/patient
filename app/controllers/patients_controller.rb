class PatientsController < ApplicationController

  filter_parameter_logging :given_name, :middle_name, :family_name, :family_name2, :birthdate, :identifier, :address

  def index
    if params[:search].blank?
      #@patients = Patient.recent
      @patients = Patient.all
    else
      @patients = Patient.search(params[:search])
    end
  end
  
  def show
    @patient = Patient.find(params[:id])
  end
  
  def new
    @patient = Patient.new
  end
  
  def create
    @patient = Patient.new(params[:patient])
    if @patient.save
      flash[:notice] = "Successfully created patient."
      redirect_to @patient
    else
      render :action => 'new'
    end
  end
  
  def edit
    @patient = Patient.find(params[:id])
  end
  
  def update
    @patient = Patient.find(params[:id])
    if @patient.update_attributes(params[:patient])
      flash[:notice] = "Successfully updated patient."
      redirect_to @patient
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @patient = Patient.find(params[:id])
    @patient.destroy
    flash[:notice] = "Successfully destroyed patient."
    redirect_to patients_url
  end
end
