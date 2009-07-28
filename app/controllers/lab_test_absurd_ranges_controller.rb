class LabTestAbsurdRangesController < ApplicationController
  def index
    @lab_test_absurd_ranges = LabTestAbsurdRange.all
  end
  
  def show
    @lab_test_absurd_range = LabTestAbsurdRange.find(params[:id])
  end
  
  def new
    @lab_test_absurd_range = LabTestAbsurdRange.new
  end
  
  def create
    @lab_test_absurd_range = LabTestAbsurdRange.new(params[:lab_test_absurd_range])
    if @lab_test_absurd_range.save
      flash[:notice] = "Successfully created lab test absurd range."
      redirect_to @lab_test_absurd_range
    else
      render :action => 'new'
    end
  end
  
  def edit
    @lab_test_absurd_range = LabTestAbsurdRange.find(params[:id])
  end
  
  def update
    @lab_test_absurd_range = LabTestAbsurdRange.find(params[:id])
    if @lab_test_absurd_range.update_attributes(params[:lab_test_absurd_range])
      flash[:notice] = "Successfully updated lab test absurd range."
      redirect_to @lab_test_absurd_range
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @lab_test_absurd_range = LabTestAbsurdRange.find(params[:id])
    @lab_test_absurd_range.destroy
    flash[:notice] = "Successfully destroyed lab test absurd range."
    redirect_to lab_test_absurd_ranges_url
  end
end
