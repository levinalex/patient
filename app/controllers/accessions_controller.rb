class AccessionsController < ApplicationController
  def index
    @accessions = Accession.all
  end
  
  def show
    @accession = Accession.find(params[:id])
    @results_grouped_by_departments = @accession.lab_test_results.group_by(&:department)
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
      redirect_to patient_url(@accession.patient_id)
    else
      render :action => 'new'
    end
  end
  
  def edit
    @accession = Accession.find(params[:id])
  end

#  def results
#    @accession = Accession.find(params[:id])
#    if @accession.update_attributes(params[:accession])
#      flash[:notice] = "Successfully edited results."
#      redirect_to accession_results_url
#    else
#      render :action => 'results'
#    end
#  end
  
  def update
    @accession = Accession.find(params[:id])
    if @accession.update_attributes(params[:accession])
      flash[:notice] = "Successfully updated accession."
      redirect_to accession_url
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
end
