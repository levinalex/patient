class AccessionsController < ApplicationController
  before_filter :require_user
  
  def index
    if params[:patient_id]
      @patient = Patient.find(params[:patient_id])
      @pending_accessions = @patient.accessions.pending(:order => 'drawn_at ASC')
      @reported_accessions = @patient.accessions.reported(:order => 'reported_at DESC')
    else
      @pending_accessions = Accession.pending
      @reported_accessions = Accession.reported.recent
    end
  end
  
  def new
    @patient = Patient.find(params[:patient_id])
    @accession = @patient.accessions.build
    @accession.drawn_at = Time.now
    @accession.drawn_by = current_user.id
    @accession.received_at = Time.now
    @accession.received_by = current_user.id
    @departments = Department.all(:order => "lab_tests.position", :include => :lab_tests)
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
    @accession = Accession.find(params[:id], :include => [:panels, {:results => :lab_test}])
    @departments = Department.all(:order => "lab_tests.position", :include => :lab_tests)
  end
  
  def update
    @accession = Accession.find(params[:id])
    if @accession.update_attributes(params[:accession])
      @accession.update_attributes(:reported_at => Time.now) if @accession.reported_at
      flash[:notice] = "Successfully updated accession."
      redirect_to accession_results_url(@accession)
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
    redirect_to accession_results_url(@accession)
  end
end
