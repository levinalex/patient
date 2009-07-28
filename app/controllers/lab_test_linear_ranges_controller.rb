class LabTestLinearRangesController < ApplicationController
  def index
    @lab_test_linear_ranges = LabTestLinearRange.all
  end
  
  def show
    @lab_test_linear_range = LabTestLinearRange.find(params[:id])
  end
  
  def new
    @lab_test_linear_range = LabTestLinearRange.new
  end
  
  def create
    @lab_test_linear_range = LabTestLinearRange.new(params[:lab_test_linear_range])
    if @lab_test_linear_range.save
      flash[:notice] = "Successfully created lab test linear range."
      redirect_to @lab_test_linear_range
    else
      render :action => 'new'
    end
  end
  
  def edit
    @lab_test_linear_range = LabTestLinearRange.find(params[:id])
  end
  
  def update
    @lab_test_linear_range = LabTestLinearRange.find(params[:id])
    if @lab_test_linear_range.update_attributes(params[:lab_test_linear_range])
      flash[:notice] = "Successfully updated lab test linear range."
      redirect_to @lab_test_linear_range
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @lab_test_linear_range = LabTestLinearRange.find(params[:id])
    @lab_test_linear_range.destroy
    flash[:notice] = "Successfully destroyed lab test linear range."
    redirect_to lab_test_linear_ranges_url
  end
end
