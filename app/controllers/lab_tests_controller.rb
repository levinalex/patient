class LabTestsController < ApplicationController
  def index
    @lab_tests = LabTest.all
  end
  
  def show
    @lab_test = LabTest.find(params[:id])
  end
  
  def new
    @lab_test = LabTest.new
  end
  
  def create
    @lab_test = LabTest.new(params[:lab_test])
    if @lab_test.save
      flash[:notice] = "Successfully created lab test."
      redirect_to @lab_test
    else
      render :action => 'new'
    end
  end
  
  def edit
    @lab_test = LabTest.find(params[:id])
  end
  
  def update
    @lab_test = LabTest.find(params[:id])
    if @lab_test.update_attributes(params[:lab_test])
      flash[:notice] = "Successfully updated lab test."
      redirect_to @lab_test
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @lab_test = LabTest.find(params[:id])
    @lab_test.destroy
    flash[:notice] = "Successfully destroyed lab test."
    redirect_to lab_tests_url
  end
end
