class AccessionsController < ApplicationController
  def index
    if params[:patient_id]
      @patient = Patient.find(params[:patient_id])
      @accessions = Accession.recent.find_all_by_patient_id(params[:patient_id])
    else
      @accessions = Accession.recent
    end
  end
  
  def new
    @patient = Patient.find(params[:patient_id])
    @accession = @patient.accessions.build
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
    @accession = Accession.find(params[:id])
  end
  
  def update
    @accession = Accession.find(params[:id])
    if @accession.update_attributes(params[:accession])
      @accession.update_attributes(:reported_at => Time.now) if @accession.reported_at
      flash[:notice] = "Successfully updated accession."
      redirect_to accession_lab_test_results_url(@accession)
    else
      render :action => 'edit'
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
    @accession.update_attribute :reported_at, Time.now
    flash[:notice] = "Reported accession"
    redirect_to accession_lab_test_results_url(@accession)
  end
end
