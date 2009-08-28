class AccessionsController < ApplicationController
  before_filter :require_user
  
  def index
    if params[:patient_id]
      @patient = Patient.find(params[:patient_id])
      @pending_accessions = Accession.pending.find_all_by_patient_id(params[:patient_id])
      @reported_accessions = Accession.reported.find_all_by_patient_id(params[:patient_id])
    else
      @pending_accessions = Accession.pending
      @reported_accessions = Accession.reported.recent
    end
  end
  
  def new
    @departments = LabTestDepartment.all(:include => :lab_tests)
    @patient = Patient.find(params[:patient_id])
    @accession = @patient.accessions.build
    @accession.drawn_at = Time.now
    @accession.drawn_by = current_user.id
  end
  
  def create
    @patient = Patient.find(params[:patient_id])
    @accession = @patient.accessions.build(params[:accession])
    if @accession.save
      flash[:notice] = "Successfully created accession."
      redirect_to edit_results_accession_url(@accession)
    else
      render :action => 'new'
    end
  end
  
  def edit
    @departments = LabTestDepartment.all(:include => :lab_tests)
    @accession = Accession.find(params[:id], :include => [:lab_test_panels, :lab_tests])
  end
  
  def update
    @accession = Accession.find(params[:id])
    if @accession.update_attributes(params[:accession])
      @accession.update_attributes(:reported_at => Time.now) if @accession.reported_at
      flash[:notice] = "Successfully updated accession."
      redirect_to accession_lab_test_results_url(@accession)
    else
      flash[:notice] = "Error!!!"
      #render :action => 'edit'
      redirect_to root_url
    end
  end
  
  def destroy
    @accession = Accession.find(params[:id])
    @accession.destroy
    flash[:notice] = "Successfully destroyed accession."
    redirect_to patient_url(@accession.patient_id)
  end

  def edit_results
    @accession = Accession.find(params[:id])
  end
  
  def report
    @accession = Accession.find(params[:id])
    @accession.update_attributes(:reported_by => current_user, :reported_at => Time.now)
    flash[:notice] = "Reported accession"
    redirect_to accession_lab_test_results_url(@accession)
  end
end
