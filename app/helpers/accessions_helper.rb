module AccessionsHelper
  def results_form_for(*args, &block)
    options = args.extract_options!.merge(:builder => ResultsFormBuilder)
    form_for(*(args + [options]), &block)
  end
end
