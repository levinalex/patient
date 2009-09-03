class LabTestNormalRangesController < ApplicationController
  def index
    @lab_test_normal_ranges = LabTestNormalRange.all(:order => "lab_test_id, age_unit, min_age")
  end
  
  def show
    @lab_test_normal_range = LabTestNormalRange.find(params[:id])
  end
  
  def new
    @lab_test_normal_range = LabTestNormalRange.new
  end
  
  def create
    @lab_test_normal_range = LabTestNormalRange.new(params[:lab_test_normal_range])
    if @lab_test_normal_range.save
      flash[:notice] = "Successfully created lab test normal range."
      redirect_to @lab_test_normal_range
    else
      render :action => 'new'
    end
  end
  
  def edit
    @lab_test_normal_range = LabTestNormalRange.find(params[:id])
  end
  
  def update
    @lab_test_normal_range = LabTestNormalRange.find(params[:id])
    if @lab_test_normal_range.update_attributes(params[:lab_test_normal_range])
      flash[:notice] = "Successfully updated lab test normal range."
      redirect_to @lab_test_normal_range
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @lab_test_normal_range = LabTestNormalRange.find(params[:id])
    @lab_test_normal_range.destroy
    flash[:notice] = "Successfully destroyed lab test normal range."
    redirect_to lab_test_normal_ranges_url
  end
end
