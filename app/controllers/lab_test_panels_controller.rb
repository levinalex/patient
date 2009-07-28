class LabTestPanelsController < ApplicationController
  def index
    @lab_test_panels = LabTestPanel.all
  end
  
  def show
    @lab_test_panel = LabTestPanel.find(params[:id])
  end
  
  def new
    @lab_test_panel = LabTestPanel.new
  end
  
  def create
    @lab_test_panel = LabTestPanel.new(params[:lab_test_panel])
    if @lab_test_panel.save
      flash[:notice] = "Successfully created lab test panel."
      redirect_to @lab_test_panel
    else
      render :action => 'new'
    end
  end
  
  def edit
    @lab_test_panel = LabTestPanel.find(params[:id])
  end
  
  def update
    @lab_test_panel = LabTestPanel.find(params[:id])
    if @lab_test_panel.update_attributes(params[:lab_test_panel])
      flash[:notice] = "Successfully updated lab test panel."
      redirect_to @lab_test_panel
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @lab_test_panel = LabTestPanel.find(params[:id])
    @lab_test_panel.destroy
    flash[:notice] = "Successfully destroyed lab test panel."
    redirect_to lab_test_panels_url
  end
end
