class LabTestResultsController < ApplicationController
  prawnto :prawn => { :top_margin => 150 }
  
  def index
    @accession = Accession.find(params[:accession_id])
    @results = @accession.lab_test_results.all(:order => 'lab_test_id').group_by(&:department_name)
  end
  
#  def show
#    @lab_test_result = @accession.lab_test_results.find(params[:id])
#  end
  
  def new
    @lab_test_result = @accession.lab_test_results.new
  end
  
  def create
    @lab_test_result = @accession.lab_test_results.new(params[:lab_test_result])
    if @lab_test_result.save
      flash[:notice] = "Successfully created lab test result."
      redirect_to [@accession, @lab_test_result]
    else
      render :action => 'new'
    end
  end
  
  def edit
    @accession = Accession.find(params[:accession_id])
    #@lab_test_result = @accession.lab_test_results.find(params[:id])
  end
  
  def update
    @lab_test_result = @accession.lab_test_results.find(params[:id])
    if @lab_test_result.update_attributes(params[:lab_test_result])
      flash[:notice] = "Successfully updated lab test result."
      redirect_to [@accession, @lab_test_result]
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @lab_test_result = @accession.lab_test_results.find(params[:id])
    @lab_test_result.destroy
    flash[:notice] = "Successfully destroyed lab test result."
    redirect_to accession_lab_test_results_url
  end
end
