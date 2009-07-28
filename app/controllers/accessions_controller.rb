class AccessionsController < ApplicationController
  def index
    @accessions = Accession.all
  end
  
  def show
    @accession = Accession.find(params[:id])
  end
  
  def new
    @accession = Accession.new
  end
  
  def create
    @accession = Accession.new(params[:accession])
    if @accession.save
      flash[:notice] = "Successfully created accession."
      redirect_to @accession
    else
      render :action => 'new'
    end
  end
  
  def edit
    @accession = Accession.find(params[:id])
  end
  
  def update
    @accession = Accession.find(params[:id])
    if @accession.update_attributes(params[:accession])
      flash[:notice] = "Successfully updated accession."
      redirect_to @accession
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @accession = Accession.find(params[:id])
    @accession.destroy
    flash[:notice] = "Successfully destroyed accession."
    redirect_to accessions_url
  end
end