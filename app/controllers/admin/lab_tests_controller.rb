class Admin::LabTestsController < Admin::ApplicationController
  def index
    @lab_tests = LabTest.all(:order => "position").group_by(&:department_name)
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
      redirect_to [:admin, @lab_test]
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
      redirect_to [:admin, @lab_test]
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @lab_test = LabTest.find(params[:id])
    @lab_test.destroy
    flash[:notice] = "Successfully destroyed lab test."
    redirect_to admin_lab_tests_url
  end
  
  def sort
    params[:lab_test].each_with_index do |id, index|
      LabTest.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end
  
=begin
  def sort
    order = params[:lab_test]
    LabTest.order(order)
    render :lab_test => order.inspect
  end
=end
end
