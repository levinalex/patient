class LabTestValueOptionsController < ApplicationController
  def index
    @lab_test_value_options = LabTestValueOption.all
  end
  
  def show
    @lab_test_value_option = LabTestValueOption.find(params[:id])
  end
  
  def new
    @lab_test_value_option = LabTestValueOption.new
  end
  
  def create
    @lab_test_value_option = LabTestValueOption.new(params[:lab_test_value_option])
    if @lab_test_value_option.save
      flash[:notice] = "Successfully created lab test value option."
      redirect_to @lab_test_value_option
    else
      render :action => 'new'
    end
  end
  
  def edit
    @lab_test_value_option = LabTestValueOption.find(params[:id])
  end
  
  def update
    @lab_test_value_option = LabTestValueOption.find(params[:id])
    if @lab_test_value_option.update_attributes(params[:lab_test_value_option])
      flash[:notice] = "Successfully updated lab test value option."
      redirect_to @lab_test_value_option
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @lab_test_value_option = LabTestValueOption.find(params[:id])
    @lab_test_value_option.destroy
    flash[:notice] = "Successfully destroyed lab test value option."
    redirect_to lab_test_value_options_url
  end
end
