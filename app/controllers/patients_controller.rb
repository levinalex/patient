class PatientsController < ApplicationController
  before_filter :require_user

  def index
    @recent = Patient.recent
    @patients = Patient.ordered.search(params[:search], params[:page])
  end
  
  def show
    @patient = Patient.find(params[:id])
  end
  
  def new
    @patient = Patient.new
    # Remove below
    @recent = Patient.recent
  end
  
  def create
    @patient = Patient.new(params[:patient])
    if @patient.save
      flash[:notice] = t('flash.patient.create')
      redirect_to patient_accessions_url(@patient)
    else
      render :action => 'new'
    end
  end
  
  def edit
    @patient = Patient.find(params[:id])
    # Remove below
    @recent = Patient.recent
  end
  
  def update
    @patient = Patient.find(params[:id])
    if @patient.update_attributes(params[:patient])
      flash[:notice] = t('flash.patient.update')
      redirect_to patient_accessions_url(@patient)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @patient = Patient.find(params[:id])
    @patient.destroy
    flash[:notice] = t('flash.patient.destroy')
    redirect_to patients_url
  end
end
