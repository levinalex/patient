class LabTestUnitsController < ApplicationController
  def index
    @lab_test_units = LabTestUnit.all
  end
  
  def show
    @lab_test_unit = LabTestUnit.find(params[:id])
  end
  
  def new
    @lab_test_unit = LabTestUnit.new
  end
  
  def create
    @lab_test_unit = LabTestUnit.new(params[:lab_test_unit])
    if @lab_test_unit.save
      flash[:notice] = "Successfully created lab test unit."
      redirect_to @lab_test_unit
    else
      render :action => 'new'
    end
  end
  
  def edit
    @lab_test_unit = LabTestUnit.find(params[:id])
  end
  
  def update
    @lab_test_unit = LabTestUnit.find(params[:id])
    if @lab_test_unit.update_attributes(params[:lab_test_unit])
      flash[:notice] = "Successfully updated lab test unit."
      redirect_to @lab_test_unit
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @lab_test_unit = LabTestUnit.find(params[:id])
    @lab_test_unit.destroy
    flash[:notice] = "Successfully destroyed lab test unit."
    redirect_to lab_test_units_url
  end
end
