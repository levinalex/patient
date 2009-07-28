class LabTestResultsController < ApplicationController
  def index
    @lab_test_results = LabTestResult.all
  end
  
  def show
    @lab_test_result = LabTestResult.find(params[:id])
  end
  
  def new
    @lab_test_result = LabTestResult.new
  end
  
  def create
    @lab_test_result = LabTestResult.new(params[:lab_test_result])
    if @lab_test_result.save
      flash[:notice] = "Successfully created lab test result."
      redirect_to @lab_test_result
    else
      render :action => 'new'
    end
  end
  
  def edit
    @lab_test_result = LabTestResult.find(params[:id])
  end
  
  def update
    @lab_test_result = LabTestResult.find(params[:id])
    if @lab_test_result.update_attributes(params[:lab_test_result])
      flash[:notice] = "Successfully updated lab test result."
      redirect_to @lab_test_result
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @lab_test_result = LabTestResult.find(params[:id])
    @lab_test_result.destroy
    flash[:notice] = "Successfully destroyed lab test result."
    redirect_to lab_test_results_url
  end
end
