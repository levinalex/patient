class LabTestCriticalRangesController < ApplicationController
  def index
    @lab_test_critical_ranges = LabTestCriticalRange.all
  end
  
  def show
    @lab_test_critical_range = LabTestCriticalRange.find(params[:id])
  end
  
  def new
    @lab_test_critical_range = LabTestCriticalRange.new
  end
  
  def create
    @lab_test_critical_range = LabTestCriticalRange.new(params[:lab_test_critical_range])
    if @lab_test_critical_range.save
      flash[:notice] = "Successfully created lab test critical range."
      redirect_to @lab_test_critical_range
    else
      render :action => 'new'
    end
  end
  
  def edit
    @lab_test_critical_range = LabTestCriticalRange.find(params[:id])
  end
  
  def update
    @lab_test_critical_range = LabTestCriticalRange.find(params[:id])
    if @lab_test_critical_range.update_attributes(params[:lab_test_critical_range])
      flash[:notice] = "Successfully updated lab test critical range."
      redirect_to @lab_test_critical_range
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @lab_test_critical_range = LabTestCriticalRange.find(params[:id])
    @lab_test_critical_range.destroy
    flash[:notice] = "Successfully destroyed lab test critical range."
    redirect_to lab_test_critical_ranges_url
  end
end
