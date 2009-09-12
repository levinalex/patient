class ResultsController < ApplicationController
  before_filter :require_user

  prawnto :prawn => {
    :inline => true,
    :top_margin => 130,
    :bottom_margin => 60}
  
  def index
    @accession = Accession.find(params[:accession_id])
#    @results = @accession.results.all.group_by(&:department_name)
#    @accession = Accession.find(params[:accession_id], :include => :patient)
    @results = @accession.results.all(:order => "lab_tests.position", :include => [{:lab_test => [:department, :unit, :lab_test_values, :reference_ranges]}]).group_by(&:department_name)
  end
    
  def new
    @result = @accession.results.new
  end
  
  def create
    @result = @accession.results.new(params[:result])
    if @result.save
      flash[:notice] = "Successfully created result."
      redirect_to [@accession, @result]
    else
      render :action => 'new'
    end
  end
  
  def edit
    @accession = Accession.find(params[:accession_id])
    #@result = @accession.results.find(params[:id])
  end
  
  def update
    @result = @accession.results.find(params[:id])
    if @result.update_attributes(params[:result])
      flash[:notice] = "Successfully updated result."
      redirect_to [@accession, @result]
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @result = @accession.results.find(params[:id])
    @result.destroy
    flash[:notice] = "Successfully destroyed result."
    redirect_to accession_results_url
  end
end
