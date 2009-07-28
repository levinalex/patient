class LabTestDepartmentsController < ApplicationController
  def index
    @lab_test_departments = LabTestDepartment.all
  end
  
  def show
    @lab_test_department = LabTestDepartment.find(params[:id])
  end
  
  def new
    @lab_test_department = LabTestDepartment.new
  end
  
  def create
    @lab_test_department = LabTestDepartment.new(params[:lab_test_department])
    if @lab_test_department.save
      flash[:notice] = "Successfully created lab test department."
      redirect_to @lab_test_department
    else
      render :action => 'new'
    end
  end
  
  def edit
    @lab_test_department = LabTestDepartment.find(params[:id])
  end
  
  def update
    @lab_test_department = LabTestDepartment.find(params[:id])
    if @lab_test_department.update_attributes(params[:lab_test_department])
      flash[:notice] = "Successfully updated lab test department."
      redirect_to @lab_test_department
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @lab_test_department = LabTestDepartment.find(params[:id])
    @lab_test_department.destroy
    flash[:notice] = "Successfully destroyed lab test department."
    redirect_to lab_test_departments_url
  end
end
