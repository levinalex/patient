class ResultsController < ApplicationController
  before_filter :require_user

  prawnto :prawn => {
    :inline => true,
    :top_margin => 150,
    :bottom_margin => 30}
  
  def index
    @accession = Accession.find(params[:accession_id])
    @results = @accession.results.all(:include => [{ :lab_test => [ :department, :unit, :lab_test_values ] }], :order => 'lab_test_id').group_by(&:department_name)
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
