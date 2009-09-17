class AccessionsController < ApplicationController
  before_filter :require_user
  
  def index
    @recent = Patient.recent
    if params[:patient_id]
      @patient = Patient.find(params[:patient_id])
      @pending_accessions = @patient.accessions.pending(:order => 'drawn_at ASC')
      @reported_accessions = @patient.accessions.reported.recently.paginate(:per_page => 10, :page => params[:page])

    else
      @pending_accessions = Accession.pending(:order => 'drawn_at ASC')
      @reported_accessions = Accession.reported.recently.paginate(:per_page => 10, :page => params[:page])
    end
  end

  def show
    @accession = Accession.find(params[:id])
    @results = @accession.results.all(:order => "lab_tests.position", :include => [{:lab_test => [:department, :unit, :lab_test_values, :reference_ranges]}]).group_by(&:department_name)
    @recent = Patient.recent
    @patient = @accession.patient
  end
      
  def new
    @recent = Patient.recent
    @patient = Patient.find(params[:patient_id])
    @accession = @patient.accessions.build
    @accession.drawn_at = Time.now
    @accession.drawn_by = current_user.id
    @accession.received_at = Time.now
    @accession.received_by = current_user.id
    @departments = Department.all(:order => "lab_tests.position", :include => :lab_tests)
  end
  
  def create
    @patient = Patient.find(params[:patient_id])
    @accession = @patient.accessions.build(params[:accession])
    if @accession.save
      flash[:notice] = "Successfully created accession."
      redirect_to edit_results_accession_url(@accession)
    else
      render :action => 'new'
    end
  end
  
  def edit
    @accession = Accession.find(params[:id], :include => [:panels, {:results => :lab_test}])
    @departments = Department.all(:order => "lab_tests.position", :include => :lab_tests)
    @recent = Patient.recent
    #@patient = @accession.patient
  end
  
  def update
    @accession = Accession.find(params[:id])
    if @accession.update_attributes(params[:accession])
      @accession.update_attributes(:reported_by => current_user.id, :reported_at => Time.now) if @accession.reported_at
      flash[:notice] = "Successfully updated accession."
      redirect_to accession_results_url(@accession)
    else
      flash[:notice] = "Error!!!"
      #render :action => 'edit'
      redirect_to root_url
    end
  end
  
  def destroy
    @accession = Accession.find(params[:id])
    @accession.destroy
    flash[:notice] = "Successfully destroyed accession."
    redirect_to patient_url(@accession.patient_id)
  end

  def edit_results
    @accession = Accession.find(params[:id])
    @recent = Patient.recent
    @patient = @accession.patient
  end
  
  def report
    @accession = Accession.find(params[:id])
    @accession.update_attributes(:reported_by => current_user.id, :reported_at => Time.now)
    flash[:notice] = "Reported accession"
    redirect_to accession_results_url(@accession)
  end
end
